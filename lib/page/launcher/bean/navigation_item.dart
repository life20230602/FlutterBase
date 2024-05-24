import 'package:flutter/cupertino.dart';
import 'package:flutter_app/utils/uri_utils.dart';

import '../../../bean/main_page_bottom_config_bean.dart';

/// 导航数据
class NavigationItem {
  NavigationItem({this.pageBean, this.defaultImage,this.activeImage, this.body});
  //菜单图片
  final String? defaultImage;
  final String? activeImage;
  //菜单对应的内容
  final Widget? body;
  //菜单配置
  final MainBottomPageBean? pageBean;

  ///是否是外部跳转
  bool canJump(){
    if(pageBean!.jumpType == 2){
      //外部跳转
      pageBean!.url.openUrl();
      return false;
    }
    return true;
  }
}
