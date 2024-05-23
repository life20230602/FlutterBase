import 'package:flutter/material.dart';
import 'package:flutter_app/base/page/app_base_page.dart';
import 'package:flutter_app/page/main/video_list_demo_page.dart';

import '../../res/colors.dart';

///首页
class LauncherPage extends AppBasePage {
  LauncherPage({super.key});

  @override
  String title() {
    return "首页";
  }

  final widgetList = [
    const VideoListPage(),
  ];

  @override
  Widget? buildBottomNavigationBar() {
    return Theme(
      data: ThemeData(
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade800,
            ),
          ],
        ),
        child: BottomNavigationBar(
          // 导航栏
          items: _items(),
          backgroundColor: Colors.black,
          currentIndex: 0,
          // 选中的位置
          onTap: (index) {
            // 点击事件
          },
          selectedItemColor: ColorRes.primary,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          unselectedItemColor: ColorRes.grey,
          type: BottomNavigationBarType.fixed, // 这个要设置，不然默认颜色 出不来
        ),
      ),
    );
  }

  @override
  bool showTitle() {
    return false;
  }

  @override
  Widget buildChild(BuildContext context) {
    return IndexedStack(
      index: 0,
      children: widgetList,
    );
  }

  /// 导航栏
  List<BottomNavigationBarItem> _items() {
    List<BottomNavigationBarItem> items = [
      const BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.add,size: 40,),
            ),
          ),
          label: "精选"),
      const BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.my_location),
            ),
          ),
          label: "我的"),
    ];
    return items;
  }
}
