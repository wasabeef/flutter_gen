
import 'package:json_annotation/json_annotation.dart';

part 'pubspec.g.dart';

/// Edit this file, then run `make generate-config-model`

@JsonSerializable()
class Pubspec {
  Pubspec({this.flutterGen, this.flutter});

  @JsonKey(name: 'flutter_gen', required: true)
  final FlutterGen? flutterGen;

  @JsonKey(name: 'flutter', required: true)
  final Flutter? flutter;

  factory Pubspec.fromJson(Map json) => _$PubspecFromJson(json);
}

@JsonSerializable()
class Flutter {
  Flutter({this.assets, this.fonts});

  @JsonKey(name: 'assets', required: true)
  final List<String>? assets;

  @JsonKey(name: 'fonts', required: true)
  final List<FlutterFonts>? fonts;

  factory Flutter.fromJson(Map json) => _$FlutterFromJson(json);
}

@JsonSerializable()
class FlutterFonts {
  FlutterFonts({this.family});

  @JsonKey(name: 'family', required: true)
  final String? family;

  factory FlutterFonts.fromJson(Map json) => _$FlutterFontsFromJson(json);
}

@JsonSerializable()
class FlutterGen {
  FlutterGen({
    this.output,
    this.lineLength1,
    this.lineLength0,
    this.assets,
    this.fonts,
    this.integrations,
    this.colors,
  }) {
    // ignore: deprecated_member_use_from_same_package
    if (lineLength1! <= 0 && lineLength0! <= 0) {
      throw ArgumentError.value(
        // ignore: deprecated_member_use_from_same_package
        lineLength1! <= 0 ? lineLength1 : lineLength0,
        lineLength1! <= 0 ? 'line_length' : 'lineLength',
      );
    }
    // ignore: deprecated_member_use_from_same_package
    if (lineLength0! > 0) {
      print('Warning: key lineLength is deprecated, use line_length instead.');
    }
  }

  @JsonKey(name: 'output', required: true)
  final String? output;

  @JsonKey(name: 'line_length', required: true)
  final int? lineLength1;

  @deprecated
  @JsonKey(name: 'lineLength', required: true)
  final int? lineLength0;

  @JsonKey(name: 'assets', required: true)
  final FlutterGenAssets? assets;

  @JsonKey(name: 'fonts', required: true)
  final FlutterGenFonts? fonts;

  @JsonKey(name: 'integrations', required: true)
  final FlutterGenIntegrations? integrations;

  @JsonKey(name: 'colors', required: true)
  final FlutterGenColors? colors;

  // Backwards compatible
  // ignore: deprecated_member_use_from_same_package
  int? get lineLength => lineLength0! > 0 ? lineLength0 : lineLength1;

  factory FlutterGen.fromJson(Map json) => _$FlutterGenFromJson(json);
}

@JsonSerializable()
class FlutterGenColors {
  FlutterGenColors({this.enabled, this.inputs});

  @JsonKey(name: 'enabled', required: true)
  final bool? enabled;

  @JsonKey(name: 'inputs', required: true)
  final List<String>? inputs;

  factory FlutterGenColors.fromJson(Map json) =>
      _$FlutterGenColorsFromJson(json);
}

@JsonSerializable()
class FlutterGenAssets {
  static const String dotDelimiterStyle = 'dot-delimiter';
  static const String snakeCaseStyle = 'snake-case';
  static const String camelCaseStyle = 'camel-case';

  FlutterGenAssets({this.enabled, this.style}) {
    if (style != dotDelimiterStyle &&
        style != snakeCaseStyle &&
        style != camelCaseStyle) {
      throw ArgumentError.value(style, 'style');
    }
  }

  @JsonKey(name: 'enabled', required: true)
  final bool? enabled;

  @JsonKey(name: 'style', required: true)
  final String? style;

  bool get isDotDelimiterStyle => style == dotDelimiterStyle;

  bool get isSnakeCaseStyle => style == snakeCaseStyle;

  bool get isCamelCaseStyle => style == camelCaseStyle;

  factory FlutterGenAssets.fromJson(Map json) =>
      _$FlutterGenAssetsFromJson(json);
}

@JsonSerializable()
class FlutterGenFonts {
  FlutterGenFonts({this.enabled});

  @JsonKey(name: 'enabled', required: true)
  final bool? enabled;

  factory FlutterGenFonts.fromJson(Map json) => _$FlutterGenFontsFromJson(json);
}

@JsonSerializable()
class FlutterGenIntegrations {
  FlutterGenIntegrations({this.flutterSvg, this.flareFlutter});

  @JsonKey(name: 'flutter_svg', required: true)
  final bool? flutterSvg;

  @JsonKey(name: 'flare_flutter', required: true)
  final bool? flareFlutter;

  factory FlutterGenIntegrations.fromJson(Map json) =>
      _$FlutterGenIntegrationsFromJson(json);
}
