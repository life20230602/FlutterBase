import 'package:flutter_app/base/logic/app_base_controller.dart';
import 'package:flutter_app/base/logic/app_exception_extension.dart';
import 'package:flutter_app/bean/main_page_bottom_config_bean.dart';
import 'package:flutter_app/page/launcher/navigation_utils.dart';
import 'package:get/get.dart';

import '../../http/rest_api_manager.dart';
import 'bean/navigation_item.dart';

///首页
class LauncherLogic extends AppBaseController {
  final menuListObs = <NavigationItem>[].obs;

  @override
  void onLoad() {
    ApiManager.getClient().getMainBottomNavigationConfig(cancelToken).then((value) {
      _initNavigation(value);
      showSuccess();
    }).catchException(this);
  }

  ///初始化导航信息
  void _initNavigation(List<MainBottomPageBean> value) {
    final itemList = <NavigationItem>[];
    for (var element in value) {
      final item = NavigationItem(
          pageBean: element,
          body: NavigationUtils.getNavigationBody(element.alias),
          defaultImage: NavigationUtils.getDefaultImageByAlias(element.alias),
          activeImage: NavigationUtils.getActiveImageByAlias(element.alias));
      itemList.add(item);
    }
    menuListObs.addAll(itemList);
  }
}
