
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:dartx/dartx.dart';
import 'package:path/path.dart';
import 'package:xml/xml.dart';

import '../settings/color_path.dart';
import '../settings/pubspec.dart';
import '../utils/color.dart';
import '../utils/error.dart';
import '../utils/string.dart';
import 'generator_helper.dart';

String generateColors(
  File pubspecFile,
  DartFormatter formatter,
  FlutterGenColors colors,
) {
  if (colors.inputs!.isEmpty) {
    throw InvalidSettingsException(
        'The value of "flutter_gen/colors:" is incorrect.');
  }

  final buffer = StringBuffer();
  buffer.writeln(header);
  buffer.writeln("import 'package:flutter/painting.dart';");
  buffer.writeln("import 'package:flutter/material.dart';");
  buffer.writeln();
  buffer.writeln('class ColorName {');
  buffer.writeln('  ColorName._();');
  buffer.writeln();

  final colorList = <_Color>[];
  colors.inputs!
      .map((file) => ColorPath(join(pubspecFile.parent.path, file)))
      .forEach((colorFile) {
    final data = colorFile.file.readAsStringSync();
    if (colorFile.isXml) {
      colorList.addAll(
          XmlDocument.parse(data).findAllElements('color').map((element) {
        return _Color.fromXmlElement(element);
      }));
    } else {
      throw 'Not supported file type ${colorFile.mime}.';
    }
  });

  colorList
      .distinctBy((color) => color.name)
      .sortedBy(((color) => color.name!) as Comparable<dynamic> Function(_Color))
      .map(_colorStatement)
      .forEach(buffer.write);

  buffer.writeln('}');
  return formatter.format(buffer.toString());
}

String _colorStatement(_Color color) {
  final buffer = StringBuffer();
  if (color.isMaterial) {
    final swatch = swatchFromPrimaryHex(color.hex);
    final statement = '''
  static const MaterialColor ${color.name!.camelCase()} = MaterialColor(
    ${swatch[500]},
    <int, Color>{
      ${swatch.entries.map((e) => '${e.key}: Color(${e.value}),').join('\n')}
    },
  );''';
    buffer.writeln(statement);
  }
  if (color.isMaterialAccent) {
    final accentSwatch = accentSwatchFromPrimaryHex(color.hex);
    final statement = '''
  static const MaterialAccentColor ${color.name!.camelCase()}Accent = MaterialAccentColor(
   ${accentSwatch[200]},
   <int, Color>{
     ${accentSwatch.entries.map((e) => '${e.key}: Color(${e.value}),').join('\n')}
    },
  );''';
    buffer.writeln(statement);
  }
  if (color.isNormal) {
    final statement =
        '''static const Color ${color.name!.camelCase()} = Color(${colorFromHex(color.hex)});''';
    buffer.writeln(statement);
  }
  return buffer.toString();
}

class _Color {
  const _Color(
    this.name,
    this.hex,
    this._types,
  );

  _Color.fromXmlElement(XmlElement element)
      : this(
          element.getAttribute('name'),
          element.text,
          element.getAttribute('type')?.split(' ') ?? List.empty(),
        );

  final String? name;

  final String hex;

  final List<String> _types;

  bool get isNormal => _types.isEmpty;

  bool get isMaterial => _types.contains('material');

  bool get isMaterialAccent => _types.contains('material-accent');
}
