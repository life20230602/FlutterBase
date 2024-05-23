import 'package:flutter/material.dart';

import '../../generated/assets.dart';
/// 加载状态：加载中 成功 错误 空页面
enum LoadingState { loading, success, error, empty }
/// 成功的构建器
typedef ContentBuilder = Widget Function(BuildContext context);

/// 自定义加载控件
class LoadingLayout extends StatelessWidget {
  const LoadingLayout(
      {super.key,
      this.state = LoadingState.loading,// 默认加载中
      this.retry,
      required this.contentBuilder});

  final LoadingState state;
  final VoidCallback? retry; // 错误 空页面 点击回调
  final ContentBuilder contentBuilder; // 成功的页面 子类实现

  @override
  Widget build(BuildContext context) {
    if (state == LoadingState.loading) {
      return _loading();
    } else if (state == LoadingState.error) {
      return _emptyOrError(Assets.imagesIconPlaceholder, "页面异常，点击重试");
    } else if (state == LoadingState.empty) {
      return _emptyOrError(Assets.imagesIconPlaceholder, "暂无数据");
    }
    return contentBuilder(context);
  }

  /// 根据项目自己修复即可
  Widget _emptyOrError(String icon, String desc) {
    return GestureDetector(
      onTap: retry,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 80,
              height: 80,
            ),
            Text(
              desc,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  /// 加载中
  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.orange.shade100,
      ),
    );
  }
}
