import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  String assetVideo = "assets/videos/pexels-rodnae-productions-6193112.mp4";
  String networkVideo =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(assetVideo,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      })
      ..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(
              _controller,
            ),
          )
        : Container();
  }
}
