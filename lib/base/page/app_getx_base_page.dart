import 'package:flutter/material.dart';
import 'package:flutter_app/base/logic/app_base_controller.dart';
import 'package:flutter_app/base/page/base_page.dart';
import 'package:flutter_app/base/widget/loading_layout.dart';
import 'package:get/get.dart';

/// 页面基类,需要关联 controller
abstract class AppGetXBasePage<T extends AppBaseController> extends GetView<T> with BasePage{
  const AppGetXBasePage({super.key});

  /// 状态控制器
  @override
  T get controller => GetInstance().find<T>(tag: logicTag());

  /// 页面的TAG 如果有需要 复写
  String? logicTag() {
    return hashCode.toString();
  }

  /// 注入控制器
  @override
  void beforeBuild(BuildContext context) {
    Get.put(createController(),tag: logicTag());
  }

  ///创建控制器
  T createController();

  @override
  void retry() {
    controller.retry();
  }

  /// 是否显示加载页面
  @override
  bool showLoadingPage() {
    return true;
  }

  @override
  Rx? getLoadingState() {
    return controller.loadingState;
  }

  /// 构建子View
  @override
  Widget buildChild(BuildContext context);
}
