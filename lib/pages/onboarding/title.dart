import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  double height;
  double width;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    width = queryData.size.width;
    height = queryData.size.height;

    return Scaffold(
      body: Container(
          child: AspectRatio(
        aspectRatio: width / height,
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover,
        ),
      )),
    );
  }
}
