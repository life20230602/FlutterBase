import 'package:get/get.dart';
import '../page/splash/splash_view.dart';

class RouteUtils {
  static final List<GetPage> pages = [
    GetPage(name: "/", page: () => const SplashPage()),
  ];
}
