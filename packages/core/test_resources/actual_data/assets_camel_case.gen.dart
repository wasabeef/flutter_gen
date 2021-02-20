// @dart = 2.10
/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  static const AssetGenImage imagesChip1 =
      AssetGenImage('assets/images/chip1.jpg');
  static const AssetGenImage imagesChip2 =
      AssetGenImage('assets/images/chip2.jpg');
  static const AssetGenImage imagesChip3Chip3 =
      AssetGenImage('assets/images/chip3/chip3.jpg');
  static const AssetGenImage imagesChip4Chip4 =
      AssetGenImage('assets/images/chip4/chip4.jpg');
  static const String imagesIconsFuchsia = 'assets/images/icons/fuchsia.svg';
  static const String imagesIconsKmm = 'assets/images/icons/kmm.svg';
  static const String imagesIconsPaint = 'assets/images/icons/paint.svg';
  static const AssetGenImage imagesLogo =
      AssetGenImage('assets/images/logo.png');
  static const AssetGenImage imagesProfileJpg =
      AssetGenImage('assets/images/profile.jpg');
  static const AssetGenImage imagesProfilePng =
      AssetGenImage('assets/images/profile.png');
  static const String jsonFruits = 'assets/json/fruits.json';
  static const AssetGenImage picturesChip5 =
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
