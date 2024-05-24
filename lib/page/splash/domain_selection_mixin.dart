import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/utils/decrypt_utils.dart';

import '../../base/http/base_dio.dart';

///域名选择
mixin DomainSelectionMixin {

  var _lineIndex = 0;

  ///请求存储桶
  requestHost() async {
    if(kDebugMode){
      onSelectionSuccess("https://pcdhu.vdt5uc.app");
    }else {
      var pingDio = BaseDio.getInstance().getPingDio();
      pingDio.options.responseType = ResponseType.bytes;
      final hostList = ["https://1wdb4.915tg6kg.vip/s1/3000/appilist.txt"];
      bool apiHostStatus = false;
      for (int i = 0; i < hostList.length; i++) {
        try {
          final response = await pingDio.get(hostList[i]);
          if (response.statusCode == 200) {
            apiHostStatus = true;
            var decryptHostData = (response.data as Uint8List).decryptHostData();
            var data = jsonDecode(decryptHostData);
            String? ret = await _checkLine(pingDio, data["domains"]);
            if (ret != null && ret.isNotEmpty) {
              onSelectionProgress("线路$_lineIndex检测成功");
              onSelectionSuccess(ret);
              return;
            }
          }
        } on Exception catch (e) {
          print(e);
        }
      }
      onSelectionError(apiHostStatus);
    }
  }

  ///检测线路
  _checkLine(Dio pingDio,dynamic line) async {
    pingDio.options.validateStatus = (status) {
      return status == 200 || (status! >= 400 && status <= 500);
    };
    var list = line as List;
    for (int i = 0; i < list.length; i++) {
      _lineIndex++;
      try {
        onSelectionProgress("正在检测线路$_lineIndex");
        await pingDio.get(list[i]);
        return list[i];
      } on Exception catch (e) {
        print(e);
      }
    }
    return null;
  }

  ///域名选择进度,文本提示
  void onSelectionProgress(String progress);

  ///域名选择失败
  ///apiHostSuccess 存储桶是否请求成功
  void onSelectionError(bool apiHostSuccess);

  ///域名选择成功
  void onSelectionSuccess(String baseUrl);
}
