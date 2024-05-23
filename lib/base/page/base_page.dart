import 'package:flutter/material.dart';
import 'package:flutter_app/base/widget/loading_layout.dart';
import 'package:get/get.dart';

/// 页面基类
mixin BasePage on Widget{

  /// 注入控制器
  void beforeBuild(BuildContext context) {}

  /// 是否显示加载页面
  bool showLoadingPage() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    beforeBuild(context);
    var child = Scaffold(
      backgroundColor: backgroundColor(),
      appBar: buildAppBar(context),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: SafeArea(child: _buildChild(context)),
    );
    return child;
  }

  ///构建底部导航
  Widget? buildBottomNavigationBar(){
    return null;
  }

  ///加载状态变量
  Rx? getLoadingState();

  ///加载失败，重试
  void retry();


  /// 加载子类的页面
  Widget _buildChild(BuildContext context) {
    // 显示加载页面
    if (showLoadingPage() && getLoadingState() != null) {
      return Obx(() => LoadingLayout(
          state: getLoadingState()!.value,
          retry: retry,
          contentBuilder: (context) {
            return buildChild(context);
          }));
    }
    return buildChild(context);
  }

  /// 标题相关 ========================================================
  /// 是否显示AppBar 默认显示
  bool showTitle() {
    return true;
  }

  /// 标题高度
  double? titleHeight() {
    return null;
  }

  /// 标题剧中
  bool titleCenter() {
    return true;
  }

  /// 标题背景色
  Color? titleBackgroundColor() {
    return null;
  }

  /// 是否显示返回按钮
  bool showBack() {
    return true;
  }

  /// 返回按钮的颜色
  Color? backColor() {
    return Colors.white;
  }

  /// 右边按钮或控件
  List<Widget>? titleActions() {
    return null;
  }

  /// 标题字体
  double titleTextSize() {
    return 18;
  }

  /// 标题字体颜色
  Color titleTextColor() {
    return Colors.white;
  }

  /// 标题字体样式
  FontWeight titleFontWeight() {
    return FontWeight.bold;
  }

  /// 标题
  String title() {
    return "";
  }

  /// 构建标题文本
  Widget buildTitle() {
    return Text(
      title(),
      style: TextStyle(
        fontSize: titleTextSize(),
        color: titleTextColor(),
        fontWeight: titleFontWeight(),
      ),
    );
  }

  /// 构建标题
  AppBar? buildAppBar(BuildContext context) {
    if (!showTitle()) {
      return null;
    }
    return AppBar(
      toolbarHeight: titleHeight(),
      centerTitle: titleCenter(),
      elevation: 0,
      // 阴影高度：0
      backgroundColor: titleBackgroundColor(),
      leading: showBack()
          ? BackButton(
              color: backColor(),
            )
          : Container(),
      actions: titleActions(),
      title: buildTitle(),
    );
  }

  /// 标题相关 ========================================================

  /// 页面背景
  Color? backgroundColor() {
    return null;
  }

  /// 构建子View
  Widget buildChild(BuildContext context);
}
