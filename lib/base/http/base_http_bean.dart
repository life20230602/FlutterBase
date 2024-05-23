import 'dart:convert';

/// 2. 网络请求处理 根据实际项目 自己统一封装的类
class HttpBean {
  HttpBean({
    this.code,
    this.msg,
    this.data,
  });

  int? code; // 响应码
  String? msg; // 响应的信息
  dynamic data; // 响应的数据

  /// 是否成功
  bool isSuccess() {
    return code == 200;
  }

  HttpBean.fromJson(dynamic json) {
    if(json is String){
      json = jsonDecode(json);
    }
    code = json['code'] as int?;
    msg = json['msg'];
    data = json['data'];
  }
}
