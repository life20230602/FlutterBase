import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'device_info_utils.dart';

class UriUtils {

  ///通过浏览器打开url
  static void openUrl(String? url) async {
    if (url != null) {
      if (!kIsWeb && Platform.isAndroid) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        if (await DeviceInfo.isSafariBrowser()) {
          await launchUrl(Uri.parse(url), webOnlyWindowName: "_self");
        } else {
          await launchUrl(Uri.parse(url));
        }
      }
    }
  }
}

extension UriExt on String {

  ///字符串url快速打开
  void openUrl() {
    UriUtils.openUrl(this);
  }
}
