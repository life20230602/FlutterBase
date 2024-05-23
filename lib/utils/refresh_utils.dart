import 'package:easy_refresh/easy_refresh.dart';

class RefreshUtils {
  static ClassicHeader header(
      {IndicatorPosition position = IndicatorPosition.above}) {
    return ClassicHeader(
      position: position,
      dragText: '下拉刷新',
      armedText: '松开刷新',
      readyText: '正在刷新...',
      processingText: '正在刷新...',
      processedText: '刷新完成',
      noMoreText: '暂无更新',
      failedText: '加载失败',
      messageText: '最近更新 %T',
    );
  }

  static ClassicFooter footer(
      {IndicatorPosition position = IndicatorPosition.above}) {
    return ClassicFooter(
      position: position,
      dragText: '上拉加载更多',
      armedText: '松开加载',
      readyText: '加载中...',
      processingText: '加载中...',
      processedText: '加载完成',
      noMoreText: '我是有底线的',
      failedText: '加载失败',
      messageText: '最近更新 %T',
    );
  }
}
