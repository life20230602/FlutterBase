import 'dart:convert';

import 'package:flutter_app/bean/user_info_bean.dart';
import 'package:flutter_app/utils/cache_utils.dart';

class UserManager{
  final _KEY = "key_user_info";

  static UserInfoBean? _userInfoBean;

  static final UserManager _INSTANCE = UserManager();

  static UserManager get() => _INSTANCE;

  void login(UserInfoBean bean){
    _userInfoBean = bean;
    CacheUtils.putString(_KEY, jsonEncode(bean.toJson()));
  }

  int getUserId(){
    return _userInfoBean!.uid;
  }

  String getToken(){
    return _userInfoBean != null ? _userInfoBean!.token : "";
  }
}