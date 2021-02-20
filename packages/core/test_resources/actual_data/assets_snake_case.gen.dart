// @dart = 2.10
/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  static const AssetGenImage images_chip1 =
      AssetGenImage('assets/images/chip1.jpg');
  static const AssetGenImage images_chip2 =
      AssetGenImage('assets/images/chip2.jpg');
  static const AssetGenImage images_chip3_chip3 =
      AssetGenImage('assets/images/chip3/chip3.jpg');
  static const AssetGenImage images_chip4_chip4 =
      AssetGenImage('assets/images/chip4/chip4.jpg');
  static const String images_icons_fuchsia = 'assets/images/icons/fuchsia.svg';
  static const String images_icons_kmm = 'assets/images/icons/kmm.svg';
  static const String images_icons_paint = 'assets/images/icons/paint.svg';
  static const AssetGenImage images_logo =
      AssetGenImage('assets/images/logo.png');
  static const AssetGenImage images_profile_jpg =
      AssetGenImage('assets/images/profile.jpg');
  static const AssetGenImage images_profile_png =
      AssetGenImage('assets/images/profile.png');
  static const String json_fruits = 'assets/json/fruits.json';
  static const AssetGenImage pictures_chip5 =
      AssetGenImage('pictures/chip5.jpg');
}

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
