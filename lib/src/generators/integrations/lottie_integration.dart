import '../../settings/asset_type.dart';
import 'integration.dart';

class LottieIntegration extends Integration {
  @override
  String get className => 'LottieGenImage';

  @override
  String classInstantiate(String path) => 'LottieGenImage\(\'$path\'\)';

  @override
  bool isSupport(AssetType type) =>
      type.extension == '.json' && type.isInLottieDir;

  @override
  bool get isConstConstructor => true;

  @override
  String get classOutput => '''class LottieGenImage {

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
}''';

  @override
  List<String> get requiredImports => [
        'package:lottie/lottie.dart',
        'package:lottie/src/providers/load_image.dart',
        'package:lottie/src/lottie_builder.dart'
      ];
}
