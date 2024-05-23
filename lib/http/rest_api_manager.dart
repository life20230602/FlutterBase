import 'package:flutter_app/http/rest_api.dart';

///api接口管理
class ApiManager {
  static late RestClient _defaultClient;

  static void setClient(RestClient client) {
    _defaultClient = client;
  }

  static RestClient getClient() => _defaultClient;
}
