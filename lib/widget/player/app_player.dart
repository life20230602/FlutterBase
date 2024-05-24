import 'package:flutter/material.dart';
import 'package:flutter_app/chewie/chewie.dart';
import 'package:flutter_app/widget/player/video_controls.dart';
import 'package:video_player/video_player.dart';

///播放完成回调
typedef OnPlayCompleted = void Function();

/// 播放器封装
class AppPlayer extends StatefulWidget {
  const AppPlayer(this.videoTitle,{
    this.url = "",
    this.autoPlay = true,
    this.onPlayCompleted,
    super.key,
  });

  final String url;
  final String videoTitle;
  final bool autoPlay;
  final OnPlayCompleted? onPlayCompleted;

  @override
  State<StatefulWidget> createState() {
    return _AppPlayerState();
  }
}

class _AppPlayerState extends State<AppPlayer> {
  // 视频播放控制器
  VideoPlayerController? _controller;
  ChewieController? _cheWieController;

  /// 播放完成监听
  void _listener() {
    var curPosition = _controller!.value.position.inMilliseconds;
    var totalPosition = _controller!.value.duration.inMilliseconds;
    if (curPosition >= totalPosition && widget.onPlayCompleted != null) {
      if (totalPosition == 0) {
        return;
      }
      widget.onPlayCompleted!();
    }
  }

  @override
  void dispose() {
    _cheWieController?.removeListener(_listener);
    _cheWieController?.dispose();
    _controller?.dispose();
    _cheWieController = null;
    _controller = null;
    super.dispose();
  }

  /// 播放错误
  Widget _buildError(BuildContext context, String errorMessage) {
    var child = Center(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          CenterPlayButton(
            isFinished: true,
            backgroundColor: Colors.black54,
            iconColor: Colors.white,
            show: true,
            isPlaying: false,
            onPressed: _started,
          ),
          const Text("播放失败，点击重试"),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 拦截所有事件
      onTap: _started,
      child: child,
    );
  }

  Future<bool> _started() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await _controller?.initialize();
    if (_controller != null) {
      _cheWieController = ChewieController(
        videoPlayerController: _controller!,
        errorBuilder: _buildError,
        // 播放速度
        materialProgressColors: ChewieProgressColors(
            // 进度条
            playedColor: Colors.orange.shade100,
            bufferedColor: Colors.grey.shade200),
        customControls: AppVideoControls(widget.videoTitle),
        autoPlay: widget.autoPlay,
        autoInitialize: true,
      );
      _cheWieController?.addListener(_listener);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _started(),
      builder: (context, snapshot) {
        if ((snapshot.data ?? false) && _cheWieController != null) {
          return Chewie(
            controller: _cheWieController!,
          );
        } else {
          // 加载中
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
