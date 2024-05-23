import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'base_page.dart';

/// 页面基类，不需要controller,而且没有状态
abstract class AppBasePage extends StatelessWidget with BasePage{
  const AppBasePage({super.key});

  /// 构建子View
  @override
  Widget buildChild(BuildContext context);

  @override
  Rx? getLoadingState() {
    return null;
  }

  @override
  void retry() {
  }
}
