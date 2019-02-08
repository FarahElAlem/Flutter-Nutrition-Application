import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  ChewieController _chewieController;

  Widget playerWidget;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/splash_intro.mp4');

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 1440 / 2880,
      autoPlay: true,
      showControls: false,
      looping: true,
    );

    playerWidget = Chewie(
      controller: _chewieController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
          Transform.scale(
            scale: 1.3,
            child: Center(child: playerWidget),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/images/logo.png'),
              )
            ],
          ),
        ],
      )),
    );
  }
}
