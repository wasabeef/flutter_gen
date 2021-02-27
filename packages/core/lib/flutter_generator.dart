// @dart = 2.10
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart';

import 'generators/assets_generator.dart';
import 'generators/colors_generator.dart';
import 'generators/fonts_generator.dart';
import 'settings/config.dart';
import 'utils/error.dart';
import 'utils/file.dart';

class FlutterGenerator {
  const FlutterGenerator(
    this.pubspecFile, {
    this.assetsName = 'assets.gen.dart',
    this.colorsName = 'colors.gen.dart',
    this.fontsName = 'fonts.gen.dart',
  });

  final File pubspecFile;
  final String assetsName;
  final String colorsName;
  final String fontsName;

  Future<void> build() async {
    Config config;
    try {
      config = await loadPubspecConfig(pubspecFile);
    } on InvalidSettingsException catch (e) {
      stderr.writeln(e.message);
      return;
    } on FileSystemException catch (e) {
      stderr.writeln(e.message);
      return;
    }

    final output = config.flutterGen.output;
    final lineLength = config.flutterGen.lineLength;
    final formatter = DartFormatter(pageWidth: lineLength, lineEnding: '\n');

    final absoluteOutput =
        Directory(normalize(join(pubspecFile.parent.path, output)));
    if (!absoluteOutput.existsSync()) {
      absoluteOutput.createSync(recursive: true);
    }

    if (config.flutterGen.colors.enabled &&
        config.flutterGen.colors.inputs.isNotEmpty) {
      final generated =
          generateColors(pubspecFile, formatter, config.flutterGen.colors);
      final colors =
          File(normalize(join(pubspecFile.parent.path, output, colorsName)));
      writeAsString(generated, file: colors);
      print('Generated: ${colors.absolute.path}');
    }

    if (config.flutterGen.assets.enabled && config.flutter.assets.isNotEmpty) {
      final generated = generateAssets(
          pubspecFile, formatter, config.flutterGen, config.flutter.assets);
      final assets =
          File(normalize(join(pubspecFile.parent.path, output, assetsName)));
      writeAsString(generated, file: assets);
      print('Generated: ${assets.absolute.path}');
    }

    if (config.flutterGen.fonts.enabled && config.flutter.fonts.isNotEmpty) {
      final generated = generateFonts(formatter, config.flutter.fonts);
      final fonts =
          File(normalize(join(pubspecFile.parent.path, output, fontsName)));
      writeAsString(generated, file: fonts);
      print('Generated: ${fonts.absolute.path}');
    }

    print('FlutterGen finished.');
  }
}
