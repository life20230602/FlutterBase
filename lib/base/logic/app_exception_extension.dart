import 'dart:async';
import 'dart:io';

import 'package:flutter_app/base/logic/app_base_refresh_controller.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../http/exception/app_server_exception.dart';
import 'app_base_controller.dart';

extension FutureExt<T> on Future<T> {
  ///显示异常
  void _showException(Object? e) {
    if (e is AppServerException) {
      if (e.message != null && e.message!.isNotEmpty) {
        SmartDialog.showToast(e.message!);
      }
    } else if (e is HttpException) {
      SmartDialog.showToast(e.message);
    } else {
      SmartDialog.showToast("网络异常，请检查网络");
    }
  }

  Future<T> catchException(AppBaseController controller, {bool showErrorPage = true}) {
    return onError((error, stackTrace){
      _showException(error);
      if (showErrorPage) {
        controller.showError();
      }
      if(controller is AppBaseRefreshController){
        controller.setRefreshSuccess();
        controller.setLoadMoreSuccess(false);
      }
      return Future.error(error ?? "");
    }).catchError(_catchError);
  }

  void _catchError(AppBaseController controller, bool showErrorPage) {
    if (showErrorPage) {
      controller.showError();
    }
    if(controller is AppBaseRefreshController){
      controller.setRefreshSuccess();
      controller.setLoadMoreSuccess(false);
    }
  }
}
