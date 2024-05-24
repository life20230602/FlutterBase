import 'package:flutter_app/base/logic/app_base_controller.dart';
import 'package:flutter_app/bean/video_list_item_bean.dart';
import 'package:flutter_app/http/rest_api_manager.dart';
import 'package:flutter_app/utils/user_manager_utils.dart';
import 'package:get/get.dart';

///短视频
class ShortVideoLogic extends AppBaseController  {
  final videoItemList = <ListElement>[].obs;

  @override
  void onLoad() {
    final body = {"uid": UserManager.get().getUserId(), "os": "h5", "token": UserManager.get().getToken()};
    ApiManager.getClient().getShortVideoList(body, cancelToken).then((value) {
      videoItemList.value = value.list;
    });
  }
}
