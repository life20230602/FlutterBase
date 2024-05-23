import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_app/base/logic/app_base_controller.dart';

enum RefreshState { refresh, loadMore, none }

///app 通用支持刷新的页面控制器
abstract class AppBaseRefreshController extends AppBaseController {
  int _page = 1;

  //刷新状态
  RefreshState _refreshState = RefreshState.none;

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
    _refreshState = RefreshState.refresh;
    onLoadData(false,_page, false);
  }

  ///加载更多回调
  loadMoreCallback() async {
    _page++;
    _refreshState = RefreshState.loadMore;
    onLoadData(false,_page, true);
  }

  ///加载数据
  void onLoadData(bool firstLoad,int page, bool isLoadMore);

  ///设置刷新成功
  void _setRefreshSuccess() {
    if(_refreshState != RefreshState.refresh) {
      return;
    }
    _refreshState = RefreshState.none;
    refreshController.finishRefresh(IndicatorResult.success);
  }

  ///设置加载成功
  void _setLoadMoreSuccess(bool noMore) {
    if(_refreshState != RefreshState.loadMore) {
      return;
    }
    _refreshState = RefreshState.none;
    if (noMore) {
      refreshController.finishLoad(IndicatorResult.noMore);
    } else {
      refreshController.finishLoad(IndicatorResult.success);
    }
  }

  ///通知界面刷新或者加载更多完成
  void complete(bool noMore){
    if(_refreshState == RefreshState.refresh){
      _setRefreshSuccess();
    }else if(_refreshState == RefreshState.loadMore){
      _setLoadMoreSuccess(noMore);
    }
  }
}
