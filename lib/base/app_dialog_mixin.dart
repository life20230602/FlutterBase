import 'package:flutter_app/widget/app_dialog_widget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

///弹窗扩展实现
mixin AppDialogMixin{

  ///显示加载框
  void showLoading() {
    SmartDialog.showLoading(msg: "正在加载...");
  }

  ///显示提示文本
  void showToast(String msg){
    SmartDialog.showToast(msg);
  }

  ///显示确认对话框
  void showConfirmDialog(String title,String message,Function onConfirm){
    SmartDialog.show(builder: (context){
      return AppDialogWidget.buildDefault(title, message,onConfirm: onConfirm);
    });
  }
}
