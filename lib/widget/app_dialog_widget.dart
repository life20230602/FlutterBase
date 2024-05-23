import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../res/colors.dart';


///app 统一确认弹窗提示框
class AppDialogWidget extends StatefulWidget {
  AppDialogWidget(this.title, this.body,
      {super.key,
      this.onConfirm,
      this.onCancel,
      this.cancelText,
      this.confirmText});

  Function? onConfirm;

  Function? onCancel;

  Widget? title;
  Widget body;

  String? confirmText;
  String? cancelText;

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

  static Function? _defaultCancel() {
    return null;
  }

  static Widget buildDefault(String title, String message,
      {Function? onConfirm,
      Function? onCancel,
      String? cancelText,
      String? confirmText}) {
    return AppDialogWidget(
      Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20,0,20,0),
        child: Text(
          message,
          style: const TextStyle(fontSize: 15),
        ),
      ),
      onConfirm: onConfirm,
      onCancel: onCancel ?? _defaultCancel,
      cancelText: cancelText,
      confirmText: cancelText,
    );
  }
}

class _State extends State<AppDialogWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center, //居中
              children: [
                _buildTitle(),
                _buildMessage(),
                const SizedBox(
                  height: 20,
                ),
                _buildButtons(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///标题
  Widget _buildTitle() {
    if(widget.title == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: widget.title,
    );
  }

  ///消息
  Widget _buildMessage() {
    return Container(
      child: widget.body,
    );
  }

  ///按钮
  Widget _buildButtons(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (widget.onCancel != null)
          TextButton(
              onPressed: () {
                SmartDialog.dismiss();
                widget.onCancel!();
              },
              child: Text(
                widget.cancelText ?? "取消",
                style: const TextStyle(color: ColorRes.grey, fontSize: 16),
              )),
        if (widget.onConfirm != null)
          TextButton(
              onPressed: () {
                SmartDialog.dismiss();
                if (widget.onConfirm != null) {
                  widget.onConfirm!();
                }
              },
              child: Text(
                widget.confirmText ?? "确认",
                style: const TextStyle(color: ColorRes.primary, fontSize: 16),
              ))
      ],
    );
  }
}
