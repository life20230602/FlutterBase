import 'dart:io';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/route/route_utils.dart';
import 'package:flutter_app/route/router_observer.dart';
import 'package:flutter_app/utils/cache_utils.dart';
import 'package:flutter_app/utils/refresh_utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化
  await CacheUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Platform.isAndroid) {
      // 设置状态栏透明
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.black);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    /// 刷新控件统一配置
    EasyRefresh.defaultHeaderBuilder = () {
      return RefreshUtils.header();
    };
    EasyRefresh.defaultFooterBuilder = () {
      return RefreshUtils.footer();
    };

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(primary: Colors.orange),
        useMaterial3: true,
      ),
      initialRoute: "/",
      getPages: RouteUtils.pages,
      navigatorObservers: [RouterNavigatorObserver()],
      builder: FlutterSmartDialog.init(),
    );
  }
}
