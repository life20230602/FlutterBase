import 'package:flutter/material.dart';
import 'package:flutter_app/chewie/chewie.dart';
import 'package:video_player/video_player.dart';

/// 播放器封装
class AppPlayer extends StatefulWidget {
  const AppPlayer({
    this.url = "",
    this.cover = "",
    this.title = "",
    this.autoPlay = true,
    super.key,
  });

  final String url;
  final String cover;
  final String title;
  final bool autoPlay;

  @override
  State<StatefulWidget> createState() {
    return _AppPlayerState();
  }
}

class _AppPlayerState extends State<AppPlayer> {
  // 视频播放控制器
  VideoPlayerController? _controller;
  ChewieController? _cheWieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
  }

  /// 全屏监听
  void _listener() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _cheWieController?.play();
    });
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

  Future<bool> started() async {
    await _controller?.initialize();
    if (_controller != null) {
      _cheWieController = ChewieController(
        videoPlayerController: _controller!,
        // 播放速度
        materialProgressColors: ChewieProgressColors(
            // 进度条
            playedColor: Colors.orange.shade100,
            bufferedColor: Colors.grey.shade200),
        customControls: const MaterialDesktopControls(),
        autoPlay: widget.autoPlay,
        autoInitialize: true,
      );
      _cheWieController?.addListener(_listener);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: started(),
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
      ),
    );
  }
}
