## flutter 基础项目结构说明

##### 目录结构

- base 基础类，定义了统一的加载状态
- bean 公共的网络数据模型，如果独有的数据结构介意和功能代码放一块，好管理
  - https://app.quicktype.io/ 可以通过此网站生成类
- chewie 视频播放器，从github 下载，方便修改源码
- generated 通过插件生成 的assets 资源管理类，Androidstudio FlutterAssetsGenerator vscode flutter-sync-assets-import
- http 项目的服务器接口调用
- page 所有页面
- res 颜色/字体大小统一管理
- route 路由管理
- utils 工具类
- widget 公共的自定义组件

#### 开发一个简单页面

参考项目中的LauncherPage

```dart
class LauncherPage extends AppBasePage {
  LauncherPage({super.key});

  @override
  String title() {
    return "首页";
  }

  @override
  bool showTitle() {
    //是否需要显示title
    return false;
  }

  @override
  Widget buildChild(BuildContext context) {
    //实现你的ui效果
    return Text("首页");
  }
}
```

#### 开发一个请求网络的页面

参考项目中的SplashPage和SplashLogic

```dart
class SplashPage extends AppGetXBasePage<SplashLogic> {
  const SplashPage({super.key});

  @override
  bool showLoadingPage() {
    return false;
  }

  @override
  bool showTitle() {
    return false;
  }

  @override
  Widget buildChild(BuildContext context) {
    return Text("text");
  }

  @override
  SplashLogic createController() {
    //实现你的控制层
    return SplashLogic();
  }
}
```

```dart
class SplashLogic extends AppBaseController with DomainSelectionMixin {

  @override
  void onLoad() {
    _login();
  }

  ///登录系统
  void _login() async {
    var os = "";
    if (kIsWeb) {
      os = "h5";
    } else {
      os = Platform.operatingSystem;
    }
    String deviceId = await DeviceInfo.getDeviceId();
    String appVersion = await DeviceInfo.getAppVersion();
    final body = {
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "version": appVersion,
      "os": os,
      "devid": deviceId,
      "invite": "",
      "user_invite": "",
      };
    ApiManager.getClient().login(body, cancelToken).then((value){
      UserManager.get().login(value);
      Get.to(LauncherPage());
    });
  }
}
```

#### 怎么实现网络请求

框架已经统一实现了接口的加解密，开发无需关注加解密

1. 在 rest_api.dart文件中声明一个接口

```dart
@POST('/api/v1/member/guest/login')
  Future<UserInfoBean> login(@Body() Map<String,dynamic> body, @CancelRequest() CancelToken cancelToken);
```

2. 声明完成之后在当前项目的根目录执行如下命令生成对应的实现

```
dart pub run build_runner build
```

3. 在controller 中通过ApiManager 调用此接口获取数据

```dart
ApiManager.getClient().login(body, cancelToken)
        .then((value){
      //value 就是你需要的数据
    }).catchException(this);//统一的异常处理
```

#### 开发一个列表页

参考项目中的VideoListPage和VideoListLogic,列表默认支持刷新和加载更多

```dart
class VideoListPage extends AppBaseRefreshPage<VideoListLogic> {
  const VideoListPage({super.key});

  @override
  Widget buildRefreshContent() {
    //实现你的列表主体内容
    return ;
  }

  @override
  bool showBack() {
    return false;
  }

  @override
  VideoListLogic createController() {
    return VideoListLogic();
  }
}
```

```dart
class VideoListLogic extends AppBaseRefreshController {
  final videoListObs = <ListElement>[].obs;

  @override
  void onLoadData(bool firstLoad, int page, bool isLoadMore) {
    //{"timestamp":1716441609650,"version":"0.1.0","os":"h5","page":1,"page_size":20,"mid":161,"type":1,"uid":22118,"token":"566e6f4cd2bd2e8b42c2a8691afc313c:89c9c8e5f160958c935be6bbcc3928e9"}
    var uid = UserManager.get().getUserId();
    final body = {"page": page, "page_size": 20, "mid": 161, "type": 1, "uid": uid};
    ApiManager.getClient().getVideoList(body, cancelToken).then((value) {
      if (isLoadMore) {
        videoListObs.addAll(value.list);
      } else {
        videoListObs.value = value.list;
      }
      showSuccess();
      //设置成功,必须调用
      complete(value.list.isEmpty);
    }).catchException(this,showErrorPage: firstLoad);//统一异常处理
  }
}
```

#### 打开一个新页面

1. 使用Get.to(NewPage()); 方法直接打开，建议固定页面可使用，不需要路由管理的
2. 使用Get.toNamed("/main"); 通过路由名称打开，需要在RouteUtils 中声明，这种方式可以通过后台配置的方式动态跳转

#### 怎么加载图片

1. 本地图片

   ```dart
   //第一种方式
   ImageUtils.loadAssetImage("assets/images/start_up.webp");
   //第二种方式
   Assets.imagesIconPlaceholder.toAssetImageWidget();
   ```
2. 普通网络图片

   ```
   //第一种方式
   ImageUtils.loadNetworkImage(url)
   //第二种方式
   url.toNetworkImageWidget();
   ```
3. 加密的网络图片

   ```
   //第一种方式
   ImageUtils.loadEncryptImage(url)
   //第二种方式
   url.toEncryptNetworkImageWidget();
   ```
