import 'dart:io';

import 'package:yaml/yaml.dart';

import '../utils/cast.dart';
import 'config.dart';

class FlutterGen {
  FlutterGen(YamlMap flutterGenMap) {
    if (flutterGenMap != null) {
      _output = safeCast<String>(flutterGenMap['output']);
      if (_output != null && !Directory(_output).existsSync()) {
        Directory(_output).createSync(recursive: true);
      }

      if (flutterGenMap.containsKey('integrations')) {
        integrations = FlutterGenIntegrations(
            safeCast<YamlMap>(flutterGenMap['integrations']));
      }
      if (flutterGenMap.containsKey('assets')) {
        assets = FlutterGenAssets(safeCast<YamlMap>(flutterGenMap['assets']));
      }
      _lineLength = safeCast<int>(flutterGenMap['lineLength']);
      if (flutterGenMap.containsKey('colors')) {
        colors = FlutterGenColors(safeCast<YamlMap>(flutterGenMap['colors']));
      }
    }
  }

  String _output;

  String get output =>
      _output != null && FileSystemEntity.isDirectorySync(_output)
          ? _output
          : Config.defaultOutput;

  int _lineLength;

  int get lineLength => _lineLength ?? Config.defaultLineLength;

  FlutterGenIntegrations integrations;

  bool get hasIntegrations => integrations != null;

  FlutterGenAssets assets;

  bool get hasAssets => assets != null;

  FlutterGenColors colors;

  bool get hasColors => colors != null && colors.hasInputs;
}

class FlutterGenColors {
  FlutterGenColors(YamlMap flutterGenMap) {
    if (flutterGenMap != null) {
      inputs = safeCast<YamlList>(flutterGenMap['inputs']);
    }
  }

  YamlList inputs;

  bool get hasInputs => inputs != null && inputs.isNotEmpty;
}

class FlutterGenAssets {
  FlutterGenAssets(YamlMap flutterGenMap) {
    if (flutterGenMap != null) {
      style = safeCast<String>(flutterGenMap['style']);
    }
  }

  String style;

  bool get isDefaultStyle => style == null || isDotDelimiterStyle;

  bool get isDotDelimiterStyle => style == 'dot-delimiter';

  bool get isSnakeCaseStyle => style == 'snake-case';

  bool get isCamelCaseStyle => style == 'camel-case';
}

class FlutterGenIntegrations {
  FlutterGenIntegrations(YamlMap flutterGenMap) {
    if (flutterGenMap != null) {
      _flutterSvg = safeCast<bool>(flutterGenMap['flutter_svg']);
      _flareFlutter = safeCast<bool>(flutterGenMap['flare_flutter']);
      _lottie = safeCast<bool>(flutterGenMap['lottie']);
    }
  }

  bool _flutterSvg;
  bool _flareFlutter;
  bool _lottie;

  bool get flutterSvg => _flutterSvg ?? false;

  bool get flareFlutter => _flareFlutter ?? false;

  bool get lottie => _lottie ?? false;
}
