import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/base/logic/app_exception_extension.dart';
import 'package:flutter_app/http/rest_api.dart';
import 'package:flutter_app/base/logic/app_base_controller.dart';
import 'package:flutter_app/base/logic/app_base_refresh_controller.dart';
import 'package:flutter_app/page/launcher/launcher_view.dart';
import 'package:flutter_app/page/splash/domain_selection_mixin.dart';
import 'package:flutter_app/utils/device_info_utils.dart';
import 'package:flutter_app/utils/user_manager_utils.dart';
import 'package:get/get.dart';

import '../../http/rest_api_manager.dart';
import '../../bean/video_list_item_bean.dart';

class VideoListLogic extends AppBaseRefreshController {
  final videoListObs = <ListElement>[].obs;

  @override
  void onLoadData(bool firstLoad, int page, bool isLoadMore) {
    //{"timestamp":1716441609650,"version":"0.1.0","os":"h5","page":1,"page_size":20,"mid":161,"type":1,"uid":22118,"token":"566e6f4cd2bd2e8b42c2a8691afc313c:89c9c8e5f160958c935be6bbcc3928e9"}
    var uid = UserManager.get().getUserId();
    final body = {"page": page, "page_size": 20, "mid": 161, "type": 1, "uid": uid};
    ApiManager.getClient().getVideoList(body, cancelToken).then((value) {
      if (isLoadMore) {
        videoListObs.addAll(value.list);
      } else {
        videoListObs.value = value.list;
      }
      showSuccess();
      if (isLoadMore) {
        setLoadMoreSuccess(value.list.isEmpty);
      } else {
        setRefreshSuccess();
      }
    }).catchException(this,showErrorPage: firstLoad);
  }
}
