import 'package:flutter/material.dart';
import 'package:flutter_app/http/rest_api_manager.dart';
import 'package:flutter_app/widget/player/app_player.dart';
import 'package:get/get.dart';

import '../../base/page/app_getx_base_page.dart';
import 'short_video_logic.dart';

///短视频页面
class ShortVideoPage extends AppGetXBasePage<ShortVideoLogic> {
  const ShortVideoPage({super.key});

  @override
  bool showLoadingPage() {
    return false;
  }

  @override
  bool enableTopSafeArea() {
    return false;
  }

  @override
  bool showTitle() {
    return false;
  }

  @override
  Widget buildChild(BuildContext context) {
    return Obx(() => PageView.builder(
      controller: PageController(),
        itemCount: controller.videoItemList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _buildItem(index);
        }));
  }

  @override
  ShortVideoLogic createController() {
    return ShortVideoLogic();
  }

  ///构建item
  Widget _buildItem(int index) {
    final item = controller.videoItemList[index];
    return AppPlayer(
      item.title,
      aspectRatio: 0,
      allowFullScreen: false,
      url: ApiManager.getPlayUrl(item.id),
    );
  }
}
