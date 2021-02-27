
import 'dart:collection';
import 'dart:io';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:dart_style/dart_style.dart';
import 'package:dartx/dartx.dart';
import 'package:path/path.dart';

import '../settings/asset_type.dart';
import '../settings/pubspec.dart';
import '../utils/error.dart';
import '../utils/string.dart';
import 'generator_helper.dart';
import 'integrations/flare_integration.dart';
import 'integrations/integration.dart';
import 'integrations/svg_integration.dart';

String generateAssets(
  File pubspecFile,
  DartFormatter formatter,
  FlutterGen flutterGen,
  List<String> assets,
) {
  if (assets.isEmpty) {
    throw InvalidSettingsException(
        'The value of "flutter/assets:" is incorrect.');
  }

  final importsBuffer = StringBuffer();
  final classesBuffer = StringBuffer();

  final integrations = <Integration>[
    if (flutterGen.integrations!.flutterSvg!) SvgIntegration(),
    if (flutterGen.integrations!.flareFlutter!) FlareIntegration(),
  ];

  if (flutterGen.assets!.isDotDelimiterStyle) {
    classesBuffer.writeln(
        _dotDelimiterStyleDefinition(pubspecFile, assets, integrations));
  } else if (flutterGen.assets!.isSnakeCaseStyle) {
    classesBuffer
        .writeln(_snakeCaseStyleDefinition(pubspecFile, assets, integrations));
  } else if (flutterGen.assets!.isCamelCaseStyle) {
    classesBuffer
        .writeln(_camelCaseStyleDefinition(pubspecFile, assets, integrations));
  } else {
    throw 'The value of "flutter_gen/assets/style." is incorrect.';
  }

  classesBuffer.writeln(_assetGenImageClassDefinition);

  final imports = <String>{'package:flutter/widgets.dart'};
  integrations
      .where((integration) => integration.isEnabled)
      .forEach((integration) {
    imports.addAll(integration.requiredImports);
    classesBuffer.writeln(integration.classOutput);
  });
  for (final package in imports) {
    importsBuffer.writeln(import(package));
  }

  final buffer = StringBuffer();
  buffer.writeln(header);
  buffer.writeln(importsBuffer.toString());
  buffer.writeln(classesBuffer.toString());
  return formatter.format(buffer.toString());
}

List<String> _getAssetRelativePathList(
  File pubspecFile,
  List<String> assets,
) {
  final assetRelativePathList = <String>[];
  for (final assetName in assets) {
    final assetAbsolutePath = join(pubspecFile.parent.path, assetName);
    if (FileSystemEntity.isDirectorySync(assetAbsolutePath)) {
      assetRelativePathList.addAll(Directory(assetAbsolutePath)
          .listSync()
          .whereType<File>()
          .map((e) => relative(e.path, from: pubspecFile.parent.path))
          .toList());
    } else if (FileSystemEntity.isFileSync(assetAbsolutePath)) {
      assetRelativePathList
          .add(relative(assetAbsolutePath, from: pubspecFile.parent.path));
    }
  }
  return assetRelativePathList;
}

AssetType? _constructAssetTree(List<String> assetRelativePathList) {
  // Relative path is the key
  final assetTypeMap = <String, AssetType>{
    '.': AssetType('.'),
  };
  for (final assetPath in assetRelativePathList) {
    var path = assetPath;
    while (path != '.') {
      assetTypeMap.putIfAbsent(path, () => AssetType(path));
      path = dirname(path);
    }
  }
  // Construct the AssetType tree
  for (final assetType in assetTypeMap.values) {
    if (assetType.path == '.') {
      continue;
    }
    final parentPath = dirname(assetType.path);
    assetTypeMap[parentPath]!.addChild(assetType);
  }
  return assetTypeMap['.'];
}

_Statement? _createAssetTypeStatement(
  File pubspecFile,
  AssetType assetType,
  List<Integration> integrations,
  String name,
) {
  final childAssetAbsolutePath = join(pubspecFile.parent.path, assetType.path);
  _Statement? statement;
  if (assetType.isSupportedImage) {
    statement = _Statement(
      type: 'AssetGenImage',
      name: name,
      value: 'AssetGenImage\(\'${posixStyle(assetType.path)}\'\)',
      isConstConstructor: true,
    );
  } else if (FileSystemEntity.isDirectorySync(childAssetAbsolutePath)) {
    final childClassName = '\$${assetType.path.camelCase().capitalize()}Gen';
    statement = _Statement(
      type: childClassName,
      name: name,
      value: '$childClassName\(\)',
      isConstConstructor: true,
    );
  } else if (!assetType.isIgnoreFile) {
    final integration = integrations.firstWhereOrNull(
      (element) => element.isSupport(assetType),
    );
    if (integration == null) {
      statement = _Statement(
        type: 'String',
        name: name,
        value: '\'${posixStyle(assetType.path)}\'',
        isConstConstructor: false,
      );
    } else {
      integration.isEnabled = true;
      statement = _Statement(
        type: integration.className,
        name: name,
        value: integration.classInstantiate(posixStyle(assetType.path)),
        isConstConstructor: integration.isConstConstructor,
      );
    }
  }
  return statement;
}

/// Generate style like Assets.foo.bar
String _dotDelimiterStyleDefinition(
  File pubspecFile,
  List<String> assets,
  List<Integration> integrations,
) {
  final buffer = StringBuffer();
  final assetRelativePathList = _getAssetRelativePathList(pubspecFile, assets);
  final assetsStaticStatements = <_Statement>[];

  final assetTypeQueue = ListQueue<AssetType>.from(
      _constructAssetTree(assetRelativePathList)!.children);

  while (assetTypeQueue.isNotEmpty) {
    final assetType = assetTypeQueue.removeFirst();
    final assetAbsolutePath = join(pubspecFile.parent.path, assetType.path);

    if (FileSystemEntity.isDirectorySync(assetAbsolutePath)) {
      final statements = assetType.children
          .mapToIsUniqueWithoutExtension()
          .map(
            (e) => _createAssetTypeStatement(
              pubspecFile,
              e.assetType!,
              integrations,
              (e.isUniqueWithoutExtension!
                      ? basenameWithoutExtension(e.assetType!.path)
                      : basename(e.assetType!.path))
                  .camelCase(),
            ),
          )
          .whereType<_Statement>()
          .toList();

      if (assetType.isDefaultAssetsDirectory) {
        assetsStaticStatements.addAll(statements);
      } else {
        final className = '\$${assetType.path.camelCase().capitalize()}Gen';
        buffer.writeln(_directoryClassGenDefinition(className, statements));
        // Add this directory reference to Assets class
        // if we are not under the default asset folder
        if (dirname(assetType.path) == '.') {
          assetsStaticStatements.add(_Statement(
            type: className,
            name: assetType.baseName.camelCase(),
            value: '$className\(\)',
            isConstConstructor: true,
          ));
        }
      }

      assetTypeQueue.addAll(assetType.children);
    }
  }
  buffer.writeln(_assetsClassDefinition(assetsStaticStatements));
  return buffer.toString();
}

/// Generate style like Assets.fooBar
String _camelCaseStyleDefinition(
  File pubspecFile,
  List<String> assets,
  List<Integration> integrations,
) {
  return _flatStyleDefinition(
    pubspecFile,
    assets,
    integrations,
    (e) => (e.isUniqueWithoutExtension!
            ? withoutExtension(e.assetType!.path)
            : e.assetType!.path)
        .replaceFirst(RegExp(r'asset(s)?'), '')
        .camelCase(),
  );
}

/// Generate style like Assets.foo_bar
String _snakeCaseStyleDefinition(
  File pubspecFile,
  List<String> assets,
  List<Integration> integrations,
) {
  return _flatStyleDefinition(
    pubspecFile,
    assets,
    integrations,
    (e) => (e.isUniqueWithoutExtension!
            ? withoutExtension(e.assetType!.path)
            : e.assetType!.path)
        .replaceFirst(RegExp(r'asset(s)?'), '')
        .snakeCase(),
  );
}

String _flatStyleDefinition(
  File pubspecFile,
  List<String> assets,
  List<Integration> integrations,
  String Function(AssetTypeIsUniqueWithoutExtension) createName,
) {
  final statements = _getAssetRelativePathList(pubspecFile, assets)
      .distinct()
      .sorted()
      .map((relativePath) => AssetType(relativePath))
      .mapToIsUniqueWithoutExtension()
      .map(
        (e) => _createAssetTypeStatement(
          pubspecFile,
          e.assetType!,
          integrations,
          createName(e),
        ),
      )
      .whereType<_Statement>()
      .toList();
  return _assetsClassDefinition(statements);
}

String _assetsClassDefinition(List<_Statement> statements) {
  final statementsBlock = statements
      .map((statement) => '  ${statement.toStaticFieldString()}')
      .join('\n');
  return '''
class Assets {
  Assets._();
  
  $statementsBlock
}
''';
}

String _directoryClassGenDefinition(
  String className,
  List<_Statement> statements,
) {
  final statementsBlock = statements
      .map((statement) => '  ${statement.toGetterString()}')
      .join('\n');
  return '''
class $className {
  const $className();
  
  $statementsBlock
}
''';
}

const String _assetGenImageClassDefinition = '''

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName)
      : _assetName = assetName,
        super(assetName);
  final String _assetName;

  Image image({
    Key key,
    ImageFrameBuilder frameBuilder,
    ImageLoadingBuilder loadingBuilder,
    ImageErrorWidgetBuilder errorBuilder,
    String semanticLabel,
    bool excludeFromSemantics = false,
    double width,
    double height,
    Color color,
    BlendMode colorBlendMode,
    BoxFit fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => _assetName;
}
''';

class _Statement {
  const _Statement({
    this.type,
    this.name,
    this.value,
    this.isConstConstructor,
  });

  final String? type;
  final String? name;
  final String? value;
  final bool? isConstConstructor;

  String toGetterString() =>
      '$type get $name => ${isConstConstructor! ? 'const' : ''} $value;';

  String toStaticFieldString() => 'static const $type $name = $value;';
}
