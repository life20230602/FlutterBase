import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/base/http/intercept/result_intercept.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/src/adapters/io_adapter.dart';
import 'intercept/header_intercept.dart';
import 'intercept/request_encrypt_intercept.dart';

class BaseDio {
  BaseDio._(); // 把构造方法私有化

  static BaseDio? _instance;

  Dio? _defaultDio;

  static BaseDio getInstance() {  // 通过 getInstance 获取实例
    _instance ??= BaseDio._();
    return _instance!;
  }

  Dio getDefaultDio() {
    if(_defaultDio != null) {
      return _defaultDio!;
    }
    _defaultDio = Dio();
    _defaultDio!.options = BaseOptions(receiveTimeout: const Duration(milliseconds: 25000),
        connectTimeout: const Duration(milliseconds: 5000)); // 设置超时时间等 ...
    // 忽略 https 证书校验
    (_defaultDio!.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _defaultDio!.interceptors.add(RequestEncryptIntercept());
    _defaultDio!.options.responseType = ResponseType.plain;
    _defaultDio!.interceptors.add(HeaderInterceptor()); // 添加拦截器，如 token之类，需要全局使用的参数
    _defaultDio!.interceptors.add(ResultInterceptor());
    if (kDebugMode) {
      // 输出参数
      _defaultDio!.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90
      ));
    }
    return _defaultDio!;
  }

  Dio getPingDio() {
    final dio = Dio();
    dio.options = BaseOptions(receiveTimeout: const Duration(milliseconds: 3000),
        connectTimeout: const Duration(milliseconds: 3000)); // 设置超时时间等 ...
    // 忽略 https 证书校验
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }
}