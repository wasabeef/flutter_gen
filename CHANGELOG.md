## 2.0.0

New Feature
- [BREAKING CHANGE] [#49](https://github.com/FlutterGen/flutter_gen/issues/49) [#53](https://github.com/FlutterGen/flutter_gen/issues/53) Name collision with flutter localization when using build_runner
  ```yaml
  # Before
  # dev_dependencies:
  #  flutter_gen: 1.3.1
  
  # After
  dev_dependencies:
    flutter_gen_runner: ^2.0.0
  ```
- [#74](https://github.com/FlutterGen/flutter_gen/issues/74) Doesn't generate assets.gen.dart when there are no assets
  ```yaml
  flutter_gen:
    fonts:
      enabled: false
  ```
- [#59](https://github.com/FlutterGen/flutter_gen/issues/59) Handling duplicate file names
  ```dart
  // generated codes
  static const AssetGenImage imagesProfileJpg = AssetGenImage('assets/images/profile.jpg'); 
  static const AssetGenImage imagesProfilePng = AssetGenImage('assets/images/profile.png');
  ```


Bug fix
- [#75](https://github.com/FlutterGen/flutter_gen/issues/75) Null safety support for generated files 

## 1.3.1

Bug fix
- [#60](https://github.com/FlutterGen/flutter_gen/issues/60) Set files like .DS_Store to the ignore list.

## 1.3.0

New Feature
- [#46](https://github.com/FlutterGen/flutter_gen/issues/46) Added support for unknown mime type files.
- Added support for [Rive (previously Flare)](https://rive.app/) files.

## 1.2.2

Bug fix
- [#51](https://github.com/FlutterGen/flutter_gen/pull/51) Added support for Key parameter in image() and svg().

## 1.2.1

Bug fix
- [#42](https://github.com/FlutterGen/flutter_gen/pull/42) Generated output folder name not being respected

## 1.2.0

New Feature
- [#40](https://github.com/FlutterGen/flutter_gen/pull/40) Support MaterialAccentColor

## 1.1.0

New Feature
  - [#33](https://github.com/FlutterGen/flutter_gen/pull/33) Support to generate flat hierarchy assets with field name style:
    - camel-case
    - snake-case
    - dot-delimiter (Default)

## 1.0.3

Bug fix
  - Insufficient params of flutter_svg [#32](https://github.com/FlutterGen/flutter_gen/pull/34)
## 1.0.2

Bug fix
  - Generate sorted statements [#27](https://github.com/FlutterGen/flutter_gen/pull/27)
  - Make Windows work properly [#28](https://github.com/FlutterGen/flutter_gen/pull/28) 

## 1.0.1

Bug fix
  - Issue [#21](https://github.com/FlutterGen/flutter_gen/issues/21)

## 1.0.0

Initial release.

- Assets generator
  - Supported image type.
  - Supported SVG as an integration.
  - And others.

- Fonts generator
- Colors generator
  - Supported xml file.
    - MaterialColor
