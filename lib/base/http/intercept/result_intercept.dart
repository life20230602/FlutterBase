import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/base/http/base_http_bean.dart';
import 'package:flutter_app/utils/decrypt_utils.dart';

import '../exception/app_server_exception.dart';

///结果处理拦截器
class ResultInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler){
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.statusCode != 200){
      throw HttpException(response.statusMessage ?? "网络异常");
    }
    var httpBean = HttpBean.fromJson(response.data);
    if(!httpBean.isSuccess()){
      throw AppServerException(code: httpBean.code, message: httpBean.msg);
    }
    //解密数据
    response.data = jsonDecode(httpBean.data.toString().decryptApiData());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    throw HttpException(err.message ?? "网络异常");
  }
}