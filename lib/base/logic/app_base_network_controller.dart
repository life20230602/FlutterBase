import 'package:dio/dio.dart';
import 'package:flutter_app/utils/app_dialog_utils.dart';

//任务
typedef Task = Future Function();

/// 公共网络处理
mixin AppBaseNetworkController{
  /// 网络请求取消用
  CancelToken cancelToken = CancelToken();

  /// 销毁
  void onNetworkClose() {
    cancelToken.cancel();
  }

  ///绑定加载框
  Future<T> bindLoading<T>(Future<T> task) async {
    AppDialogUtils.showLoadingDialog();
    try {
      return await task;
    } finally {
      AppDialogUtils.dismissLoadingDialog();
    }
  }
}
