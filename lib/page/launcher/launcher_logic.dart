import 'package:flutter_app/base/logic/app_base_controller.dart';
import 'package:flutter_app/base/logic/app_exception_extension.dart';

import '../../http/rest_api_manager.dart';

///首页
class LauncherLogic extends AppBaseController {
  @override
  void onLoad() {
    ApiManager.getClient()
        .getMainBottomNavigationConfig(cancelToken)
        .then((value) {
      print(value);
    }).catchException(this);
  }
}
