import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/base/logic/app_exception_extension.dart';
import 'package:flutter_app/http/rest_api.dart';
import 'package:flutter_app/base/logic/app_base_controller.dart';
import 'package:flutter_app/page/launcher/launcher_view.dart';
import 'package:flutter_app/page/splash/domain_selection_mixin.dart';
import 'package:flutter_app/utils/device_info_utils.dart';
import 'package:flutter_app/utils/user_manager_utils.dart';
import 'package:get/get.dart';

import '../../http/rest_api_manager.dart';

class SplashLogic extends AppBaseController with DomainSelectionMixin {
  //ui更新文本，通过obs关联刷新
  var lineTextObs = "".obs;

  @override
  void onLoad() {
    requestHost();
  }

  @override
  void onSelectionError(bool apiHostSuccess) {
    if (apiHostSuccess) {
      lineTextObs.value = "线路获取失败,请检查网络或官网更新应用~";
    } else {
      lineTextObs.value = "该包出错，请前往官网重新下载或重新打开~";
    }
  }

  @override
  void onSelectionProgress(String progress) {
    lineTextObs.value = progress;
  }

  @override
  void onSelectionSuccess(String baseUrl) {
    //初始化网络请求
    ApiManager.initClient(baseUrl);
    _login();
  }

  ///登录系统
  void _login() async {
    var os = "";
    if (kIsWeb) {
      os = "h5";
    } else {
      os = Platform.operatingSystem;
    }
    String deviceId = await DeviceInfo.getDeviceId();
    String appVersion = await DeviceInfo.getAppVersion();
    final body = {
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "version": appVersion,
      "os": os,
      "devid": deviceId,
      "invite": "",
      "user_invite": "",
      };
    ApiManager.getClient().login(body, cancelToken)
        .then((value){
      UserManager.get().login(value);
      //路由跳转首页
      Get.to(LauncherPage());
    }).catchException(this);//统一的异常处理
  }
}
