import 'package:flutter/widgets.dart';
import 'package:flutter_app/generated/assets.dart';

import '../shortvideo/short_video_view.dart';

class NavigationUtils{

  static String getDefaultImageByAlias(String alias){
    switch(alias){
      case "home":
        return Assets.imagesIconLauncherNavigationHome;
      case "videos":
        return Assets.imagesIconLauncherNavigationShort;
      case "anwang":
        return Assets.imagesIconLauncherNavigationAw;
      case "my":
        return Assets.imagesIconLauncherNavigationMe;
    }
    return Assets.imagesIconLauncherNavigationHome;
  }

  static String getActiveImageByAlias(String alias){
    switch(alias){
      case "home":
        return Assets.imagesIconLauncherNavigationHomeActive;
      case "videos":
        return Assets.imagesIconLauncherNavigationShortActive;
      case "anwang":
        return Assets.imagesIconLauncherNavigationAwActive;
      case "my":
        return Assets.imagesIconLauncherNavigationMeActive;
    }
    return Assets.imagesIconLauncherNavigationHomeActive;
  }

  ///获取导航对应的内容
  static Widget getNavigationBody(String alias){
    switch(alias){
      case "videos":
        return const ShortVideoPage();
    }
    return Text(alias);
  }
}