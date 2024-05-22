/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/cancel.svg
  String get cancel => 'assets/icon/cancel.svg';

  /// File path: assets/icon/google.svg
  String get google => 'assets/icon/google.svg';

  /// List of all assets
  List<String> get values => [cancel, google];
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/add_image.png
  AssetGenImage get addImage =>
      const AssetGenImage('assets/image/add_image.png');

  /// File path: assets/image/background_signin.png
  AssetGenImage get backgroundSignin =>
      const AssetGenImage('assets/image/background_signin.png');

  /// File path: assets/image/intro1.png
  AssetGenImage get intro1 => const AssetGenImage('assets/image/intro1.png');

  /// File path: assets/image/intro2.png
  AssetGenImage get intro2 => const AssetGenImage('assets/image/intro2.png');

  /// File path: assets/image/intro3.png
  AssetGenImage get intro3 => const AssetGenImage('assets/image/intro3.png');

  /// File path: assets/image/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/image/logo.png');

  /// File path: assets/image/quiz_background.png
  AssetGenImage get quizBackground =>
      const AssetGenImage('assets/image/quiz_background.png');

  /// File path: assets/image/quiz_number.svg
  String get quizNumber => 'assets/image/quiz_number.svg';

  /// List of all assets
  List<dynamic> get values => [
        addImage,
        backgroundSignin,
        intro1,
        intro2,
        intro3,
        logo,
        quizBackground,
        quizNumber
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImageGen image = $AssetsImageGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
