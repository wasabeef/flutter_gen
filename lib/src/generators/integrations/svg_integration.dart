import '../../settings/asset_type.dart';
import 'integration.dart';

class SvgIntegration extends Integration {
  @override
  List<String> get requiredImports => [
        'package:flutter_svg/flutter_svg.dart',
        'package:flutter/services.dart',
        'package:flutter/foundation.dart'
      ];

  @override
  String get classOutput => '''class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  Widget svg({
    Key key,
    bool matchTextDirection = false,
    AssetBundle bundle,
    String package,
    double width,
    double height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder placeholderBuilder,
    Color color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    //
    ImageFrameBuilder frameBuilderWeb,
    ImageLoadingBuilder loadingBuilderWeb,
    ImageErrorWidgetBuilder errorBuilderWeb,
    ImageRepeat repeatWeb = ImageRepeat.noRepeat,
    Rect centerSliceWeb,
    bool gaplessPlaybackWeb = false,
    bool isAntiAliasWeb = false,
    FilterQuality filterQualityWeb = FilterQuality.low,
  }) {
     if (kIsWeb)
      return Image.network(
        _assetName,
        key: key,
        matchTextDirection: matchTextDirection,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        color: color,
        colorBlendMode: colorBlendMode,
        semanticLabel: semanticsLabel,
        excludeFromSemantics: excludeFromSemantics,
        frameBuilder: frameBuilderWeb,
        loadingBuilder: loadingBuilderWeb,
        errorBuilder: errorBuilderWeb,
        repeat: repeatWeb,
        centerSlice: centerSliceWeb,
        gaplessPlayback: gaplessPlaybackWeb,
        isAntiAlias: isAntiAliasWeb,
        filterQuality: filterQualityWeb,
      );
    else
      return SvgPicture.asset(
        _assetName,
        key: key,
        matchTextDirection: matchTextDirection,
        bundle: bundle,
        package: package,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
        placeholderBuilder: placeholderBuilder,
        color: color,
        colorBlendMode: colorBlendMode,
        semanticsLabel: semanticsLabel,
        excludeFromSemantics: excludeFromSemantics,
        clipBehavior: clipBehavior,
      );
  }

  String get path => _assetName;
}''';

  @override
  String get className => 'SvgGenImage';

  @override
  String classInstantiate(String path) => 'SvgGenImage\(\'$path\'\)';

  @override
  bool isSupport(AssetType type) => type.mime == 'image/svg+xml';

  @override
  bool get isConstConstructor => true;
}
