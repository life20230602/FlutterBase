import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_app/base/logic/app_base_controller.dart';

///app 通用支持刷新的页面控制器
abstract class AppBaseRefreshController extends AppBaseController {
  int _page = 1;

  ///获取当前页码
  int getPage() => _page;

  EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void onLoad() {
    onLoadData(true,_page, false);
  }

  ///刷新控件回调
  refreshCallback() async {
    _page = 1;
    onLoadData(false,_page, false);
  }

  ///加载更多回调
  loadMoreCallback() async {
    _page++;
    onLoadData(false,_page, true);
  }

  ///加载数据
  void onLoadData(bool firstLoad,int page, bool isLoadMore);

  ///设置刷新成功
  void setRefreshSuccess() {
    refreshController.finishRefresh(IndicatorResult.success);
  }

  ///设置加载成功
  void setLoadMoreSuccess(bool noMore) {
    if (noMore) {
      refreshController.finishLoad(IndicatorResult.noMore);
    } else {
      refreshController.finishLoad(IndicatorResult.success);
    }
  }
}
