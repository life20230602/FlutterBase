import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/utils/cache_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'decrypt_utils.dart';

class DeviceInfo {
  static const CACHE_KEY = "cache_device_id";

  ///获取设备ID
  static Future<String> getDeviceId() async {
    var deviceId = CacheUtils.getString(CACHE_KEY);
    if (deviceId != null) return deviceId;
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        const androidIdPlugin = AndroidId();
        final String? androidId = await androidIdPlugin.getId();
        if (androidId != null) {
          return Future.value(androidId);
        }
      } else {
        final deviceInfoPlugin = DeviceInfoPlugin();
        final info = await deviceInfoPlugin.iosInfo;
        return Future.value(info.identifierForVendor);
      }
    }
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.webBrowserInfo;
    var id = DecryptUtils.md5Encode(deviceInfo.toString() + DateTime.now().millisecondsSinceEpoch.toString());
    CacheUtils.putString(CACHE_KEY, id);
    return Future.value(id);
  }

  ///获取设备描述信息
  static Future<String> getDeviceDesc() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String deviceDesc = "";
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionInfo = packageInfo.version + packageInfo.buildNumber;
    if (!kIsWeb && Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      deviceDesc = info.brand + info.model + versionInfo;
      return Future.value(deviceDesc);
    }
    WebBrowserInfo browserInfo = await deviceInfoPlugin.webBrowserInfo;
    return Future.value("${browserInfo.userAgent}");
  }

  ///获取版本号
  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return Future.value(packageInfo.version);
  }

  /// 判断是否为uc浏览器
  static Future<bool> isUcBrowser() async {
    if (!kIsWeb) {
      return Future.value(false);
    }
    final deviceInfoPlugin = DeviceInfoPlugin();
    WebBrowserInfo browserInfo = await deviceInfoPlugin.webBrowserInfo;
    return Future.value((browserInfo.userAgent ?? "").contains("UCBrowser"));
  }

  /// 判断是否为Safari浏览器
  static Future<bool> isSafariBrowser() async {
    if (!kIsWeb) {
      return Future.value(false);
    }
    final deviceInfoPlugin = DeviceInfoPlugin();
    WebBrowserInfo browserInfo = await deviceInfoPlugin.webBrowserInfo;
    var userAgent = browserInfo.userAgent ?? "";
    return Future.value(userAgent.contains("Safari") && !userAgent.contains("Chrome"));
  }
}
