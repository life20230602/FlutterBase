import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/chewie/chewie_player.dart';
import 'package:flutter_app/chewie/helpers/adaptive_controls.dart';
import 'package:video_player/video_player.dart';

class PlayerWithControls extends StatelessWidget {
  const PlayerWithControls({super.key});

  @override
  Widget build(BuildContext context) {
    final ChewieController chewieController = ChewieController.of(context);

    Widget buildControls(
      BuildContext context,
      ChewieController chewieController,
    ) {
      return chewieController.showControls
          ? chewieController.customControls ?? const AdaptiveControls()
          : const SizedBox();
    }

    Widget buildPlayerWithControls(
      ChewieController chewieController,
      BuildContext context,
    ) {
      Widget child;
      if (!kIsWeb) {
        child = AspectRatio(
          aspectRatio: chewieController.aspectRatio ??
              chewieController.videoPlayerController.value.aspectRatio,
          child: VideoPlayer(chewieController.videoPlayerController),
        );
      } else {
        child = VideoPlayer(chewieController.videoPlayerController);
      }
      return Stack(
        children: <Widget>[
          if (chewieController.placeholder != null)
            chewieController.placeholder!,
          InteractiveViewer(
            transformationController: chewieController.transformationController,
            maxScale: chewieController.maxScale,
            panEnabled: chewieController.zoomAndPan,
            scaleEnabled: chewieController.zoomAndPan,
            child: Center(
              child: child,
            ),
          ),
          if (chewieController.overlay != null) chewieController.overlay!,
          if (!chewieController.isFullScreen)
            buildControls(context, chewieController)
          else
            SafeArea(
              bottom: false,
              child: buildControls(context, chewieController),
            ),
        ],
      );
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Center(
        child: buildPlayerWithControls(chewieController, context),
      );
    });
  }
}
