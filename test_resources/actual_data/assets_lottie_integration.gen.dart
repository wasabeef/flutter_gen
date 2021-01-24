/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/src/providers/load_image.dart';
import 'package:lottie/src/lottie_builder.dart';

class $AssetsLottieGen {
  const $AssetsLottieGen();

  LottieGenImage get check => const LottieGenImage('assets/lottie/check.json');
}

class Assets {
  Assets._();

  static const $AssetsLottieGen lottie = $AssetsLottieGen();
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

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double> controller,
    bool animate,
    FrameRate frameRate,
    bool repeat,
    bool reverse,
    LottieDelegates delegates,
    LottieOptions options,
    void Function(LottieComposition) onLoaded,
    LottieImageProviderFactory imageProviderFactory,
    Key key,
    AssetBundle bundle,
    LottieFrameBuilder frameBuilder,
    double width,
    double height,
    BoxFit fit,
    Alignment alignment,
    String package,
    bool addRepaintBoundary,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      width: width,
      height: height,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
    );
  }

  String get path => _assetName;
}
