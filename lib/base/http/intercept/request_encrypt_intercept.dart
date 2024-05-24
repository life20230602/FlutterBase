import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/base/http/base_http_bean.dart';
import 'package:flutter_app/utils/decrypt_utils.dart';

import '../exception/app_server_exception.dart';

///请求参数加密
class RequestEncryptIntercept extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler){
    //只加密post参数
    if(options.method.toLowerCase() == "post" && options.data != null){
      final data = jsonEncode(options.data).encryptApiData();
      options.data = {"data":data};
    }
    handler.next(options);
  }
}