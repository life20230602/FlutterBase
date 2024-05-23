import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:octo_image/src/image/fade_widget.dart';

import '../utils/decrypt_utils.dart';
import '../utils/image_utils.dart';

class ImageKey {
  ImageKey(this.url, this.cacheKey);

  final String url;
  final String cacheKey;
}

///图片自定义解密
class CustomDecryptImage extends StatefulWidget {
  const CustomDecryptImage(
    this.url, {
    this.fit = BoxFit.cover,
    this.showDefaultCover = true,
    super.key,
  });

  final String? url;
  final BoxFit? fit;
  final bool showDefaultCover;

  @override
  State<CustomDecryptImage> createState() {
    return _CustomImageState(url, fit, showDefaultCover);
  }
}

class _CustomImageState extends State<CustomDecryptImage> {
  _CustomImageState(this.url, this.fit, this.showDefaultCover);

  static final manager = DefaultCacheManager();
  final String? url;
  final BoxFit? fit;
  final bool showDefaultCover;
  Uint8List? images;
  var update = true;

  String? getCacheKey() {
    return url?.split("?").first;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadImage().then((image) {
      if (update) {
        images = image;
        if (images != null && update) {
          setState(() {});
        }
      }
    }).catchError((e, s) {
    });
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    update = true;
  }

  @override
  void deactivate() {
    update = false;
    super.deactivate();
    //print("========== deactivate");
  }

  @override
  void dispose() {
    update = false;
    super.dispose();
    //print("========== dispose");
  }

  Future<Uint8List?> _loadImage() async {
    var cacheKey = getCacheKey();
    if (update && url != null && cacheKey != null) {
      return _image(ImageKey(url!, cacheKey));
    }
    return Future.value();
  }

  static Future<Uint8List?> _image(ImageKey key) async {
    var url = key.url;
    var file = await manager.getSingleFile(url, key: key.cacheKey);
    var bytes = await file.readAsBytes();
    try {
      return Future.value(DecryptUtils.decryptImage(bytes));
    } catch (e, s) {
      //print("=== _image =============== ${e.toString()}");
      // 这个是解码失败后，用原始数据
      return Future.value(Uint8List.fromList(bytes));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget defaultCover = showDefaultCover ? ImageUtils.buildDefaultCoverWidget() : Container();
    //动画实现，会卡顿
    return Stack(fit: StackFit.expand, children: [
      defaultCover,
      if (images != null)
        FadeWidget(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: Image.memory(images!,fit: fit,),
        ),
    ]);
  }
}
