import 'package:flutter_app/http/rest_api.dart';
import 'package:flutter_app/utils/user_manager_utils.dart';

///api接口管理
class ApiManager {
  static late RestClient _defaultClient;
  static late String _defaultBaseUrl;

  static void initClient(String baseUrl) {
    _defaultBaseUrl = baseUrl;
    _defaultClient = RestClient(baseUrl: baseUrl);
  }

  static RestClient getClient() => _defaultClient;

  ///获取播放地址
  static String getPlayUrl(int vodId) {
    final userId = UserManager.get().getUserId();
    final token = UserManager.get().getToken();
    return "https://pcdhu.vdt5uc.app/api/v2/video/player.m3u8?vid=$vodId&uid=$userId&token=$token";
  }
}
