import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/justcall1.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.setLooping(false);

    // Navigate to the home screen once the video ends
    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.position == _controller.value.duration) {
        context.go("/");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        body: Container(
          height: heightSize,
          width: widthSize,
          color: Colors.white,
          child: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
