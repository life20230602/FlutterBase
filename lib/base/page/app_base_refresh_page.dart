import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/logic/app_base_refresh_controller.dart';

import 'app_getx_base_page.dart';

///基础刷新父类
abstract class AppBaseRefreshPage<T extends AppBaseRefreshController> extends AppGetXBasePage<T> {
  const AppBaseRefreshPage({super.key});

  @override
  bool showTitle() {
    return false;
  }

  ///是否启用下拉刷新
  bool enableRefresh(){
    return true;
  }

  ///是否启用加载更多
  bool enableLoadMore(){
    return true;
  }

  @override
  Widget buildChild(BuildContext context) {
    return EasyRefresh(
      controller: controller.refreshController,
      onRefresh: enableRefresh() ? controller.refreshCallback : null,
      onLoad: enableLoadMore() ? controller.loadMoreCallback : null,
      child: buildRefreshContent(),
    );
  }

  ///构建刷新主体内容
  Widget buildRefreshContent();
}
