import 'package:dio/dio.dart';
import 'package:flutter_app/base/http/base_dio.dart';
import 'package:flutter_app/bean/user_info_bean.dart';
import 'package:flutter_app/bean/video_list_item_bean.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../bean/main_page_bottom_config_bean.dart';

part 'rest_api.g.dart';

/// 如果在此文件修改，需要通过命令生成 dart pub run build_runner build
@RestApi()
abstract class RestClient {

  factory RestClient({Dio? dio, String? baseUrl}){
    dio ??= BaseDio.getInstance().getDefaultDio();
    return _RestClient(dio,baseUrl: baseUrl);
  }

  @POST('/api/v2/video/bottom/navigation')
  Future<List<MainBottomPageBean>> getMainBottomNavigationConfig(@CancelRequest() CancelToken cancelToken);

  ///登录
  @POST('/api/v1/member/guest/login')
  Future<UserInfoBean> login(@Body() Map<String,dynamic> body, @CancelRequest() CancelToken cancelToken);

  ///获取视频列表
  @POST('/api/v2/video/module/video/list')
  Future<VideoListBean> getVideoList(@Body() Map<String,dynamic> body, @CancelRequest() CancelToken cancelToken);
}