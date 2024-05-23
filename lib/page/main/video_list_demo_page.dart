import 'package:flutter/material.dart';
import 'package:flutter_app/base/app_dialog_mixin.dart';
import 'package:flutter_app/base/page/app_base_refresh_page.dart';
import 'package:flutter_app/bean/video_list_item_bean.dart';
import 'package:flutter_app/page/main/video_list_logic.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class VideoListPage extends AppBaseRefreshPage<VideoListLogic> with AppDialogMixin {
  const VideoListPage({super.key});

  @override
  Widget buildRefreshContent() {
    return Obx(() => AlignedGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        itemCount: controller.videoListObs.length,
        itemBuilder: (context, index) {
          return _buildItem(index);
        }));
  }

  @override
  bool showTitle() {
    return true;
  }

  @override
  String title() {
    return "视频列表";
  }

  @override
  bool showBack() {
    return false;
  }

  @override
  VideoListLogic createController() {
    return VideoListLogic();
  }

  ///创建item
  Widget _buildItem(int index) {
    final ListElement item = controller.videoListObs[index];
    return GestureDetector(
      onTap: () {
        showLoading();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(item),
          _buildTitle(item),
        ],
      ),
    );
  }

  Widget _buildImage(ListElement item) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          item.horizontalCover.toEncryptNetworkImageWidget(radius: 5),
          Positioned(
            left: 20,
            bottom: 10,
            child: Text(
              "${item.clickCount}播放",
              style: const TextStyle(fontSize: 11),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 10,
            child: Text(
              "${item.videoLength}",
              style: const TextStyle(fontSize: 11),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(ListElement item) {
    return Text(
      item.title,
      style: const TextStyle(fontSize: 13),
    );
  }
}
