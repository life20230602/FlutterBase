import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../widget/loading_layout.dart';

/// 1. 页面的状态管理
abstract class AppBaseController extends GetxController{
  /// 页面加载状态 在自定义加载类中
  var loadingState = LoadingState.loading.obs;
  /// 网络请求取消用
  CancelToken cancelToken = CancelToken();

  /// 初始化
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    onLoad();
  }

  /// 销毁
  @override
  void onClose() {
    cancelToken.cancel();
    super.onClose();
  }

  /// 重试
  void retry() {
    showLoading();
    // 准备好
    onLoad();
  }

  /// 显示成功页面
  void showSuccess() {
    if (loadingState.value == LoadingState.success) {
      return;
    }
    loadingState.value = LoadingState.success;
  }

  /// 显示空页面
  void showEmpty() {
    if (loadingState.value == LoadingState.empty) {
      return;
    }
    loadingState.value = LoadingState.empty;
  }

  /// 显示错误页面
  void showError() {
    if (loadingState.value == LoadingState.error) {
      return;
    }
    loadingState.value = LoadingState.error;
  }

  /// 显示加载中页面
  void showLoading() {
    if (loadingState.value == LoadingState.loading) {
      return;
    }
    loadingState.value = LoadingState.loading;
  }

  ///加载数据
  void onLoad();
}

