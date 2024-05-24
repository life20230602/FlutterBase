import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/decrypt_image_widget.dart';

import '../generated/assets.dart';

/// 图片加载工具类
class ImageUtils {
  /// 加载本地资源图片
  static Widget loadAssetImage(String assetsUrl, {double? width, double? height, double radius = 0, BoxFit? fit}) {
    if (radius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          assetsUrl,
          height: height,
          width: width,
          fit: fit,
        ),
      );
    }
    return Image.asset(
      assetsUrl,
      height: height,
      width: width,
      fit: fit,
    );
  }

  static Widget buildDefaultCoverWidget({double? width, double? height}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.white,
        ),
        loadAssetImage(Assets.imagesIconPlaceholder, width: width ?? 120, height: height ?? 120, fit: BoxFit.contain)
      ],
    );
  }

  /// 加载网络图片, placeholder:占位图和加载失败时显示同一张图片
  static Widget loadNetworkImage(String imageUrl,
      {String placeholder = "none", double? width, double? height, double radius = 0, BoxFit fit = BoxFit.cover}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) {
          return ImageUtils.buildDefaultCoverWidget(width: width, height: height);
        },
        errorWidget: (context, url, error) => ImageUtils.buildDefaultCoverWidget(width: width, height: height),
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }

  ///加载加密的图片
  static Widget loadEncryptImage(
    String url, {
    BoxFit? fit,
    double radius = 0,
  }) {
    if (radius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CustomDecryptImage(url, fit: fit),
      );
    }
    return CustomDecryptImage(
      url,
      fit: fit,
    );
  }
}

extension ImageLoadExt on String {
  ///字符串快速转网络图片加载widget
  Widget toNetworkImageWidget({double? width, double? height, BoxFit? fit, radius}) {
    return ImageUtils.loadNetworkImage(this, width: width, height: height, radius: radius);
  }

  ///图片地址快速加载加密的网络图片
  Widget toEncryptNetworkImageWidget({
    BoxFit? fit,
    double radius = 0,
  }) {
    if (radius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CustomDecryptImage(this),
      );
    }
    return CustomDecryptImage(this);
  }

  ///字符串转 assets 图片加载
  Widget toAssetImageWidget({double? width, double? height, BoxFit? fit, double radius = 0}) {
    return ImageUtils.loadAssetImage(this, width: width, height: height, fit: fit, radius: radius);
  }

  ///字符串加载图片
  Widget toImageWidget({
    BoxFit? fit,
    double radius = 0,
  }) {
    if (startsWith("http")) {
      return toNetworkImageWidget(fit: fit, radius: radius);
    }
    return toAssetImageWidget(fit: fit, radius: radius);
  }
}
