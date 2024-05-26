import 'package:flutter/material.dart';
import 'package:flutter_app/base/page/app_getx_base_page.dart';
import 'package:flutter_app/page/demo/video_list_demo_page.dart';
import 'package:flutter_app/page/launcher/launcher_logic.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:get/get.dart';

import '../../res/colors.dart';
import '../../res/dimens.dart';
import 'bean/navigation_item.dart';

///首页
class LauncherPage extends AppGetXBasePage<LauncherLogic> {
  LauncherPage({super.key});

  final _currentIndex = 0.obs;

  @override
  Widget? buildBottomNavigationBar() {
    return Obx(() => _buildNavigationBar(controller.menuListObs));
  }

  @override
  bool enableTopSafeArea() {
    return false;
  }

  Widget _buildNavigationBar(List<NavigationItem> items){
    if(items.isEmpty){
      return Container();
    }
    return Theme(
      data: ThemeData(brightness: Brightness.dark, splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: BottomNavigationBar(
        // 导航栏
        items: _items(),
        backgroundColor: Colors.black,
        currentIndex: _currentIndex.value,
        // 选中的位置
        onTap: (index) {
          if(index == 2){
            Get.to(const VideoListPage());
            return;
          }
          if(controller.menuListObs[index].canJump()) {
            // 点击事件
            _currentIndex.value = index;
          }
        },
        selectedItemColor: ColorRes.primary,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        unselectedItemColor: ColorRes.grey,
        type: BottomNavigationBarType.fixed, // 这个要设置，不然默认颜色 出不来
      ),
    );
  }

  @override
  bool showTitle() {
    return false;
  }

  @override
  Widget buildChild(BuildContext context) {
    final bodyList = controller.menuListObs.map((element) => element.body!).toList();
    return Obx(() => IndexedStack(
      index: _currentIndex.value,
      children: bodyList,
    ));
  }

  /// 导航栏
  List<BottomNavigationBarItem> _items() {
    final items = <BottomNavigationBarItem>[];
    for (var element in controller.menuListObs) {
      items.add(BottomNavigationBarItem(
          icon: _buildIcon(element.defaultImage.toString()), activeIcon: _buildIcon(element.activeImage.toString()), label: element.pageBean?.title));
    }
    return items;
  }

  @override
  LauncherLogic createController() {
    return LauncherLogic();
  }

  Widget _buildIcon(String image) {
    return Container(
      width: Dimens.size30,
      height: Dimens.size30,
      padding: const EdgeInsets.all(5),
      child: image.toAssetImageWidget(),
    );
  }
}
