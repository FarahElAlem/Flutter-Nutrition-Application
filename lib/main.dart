import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/home.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'db2',
      options: const FirebaseOptions(
          googleAppID: '1:860653339755:android:ee11c9b993be49dd',
          apiKey: 'AIzaSyAC-htfPSWJJshQwgjEUcN3aHB0nIbHdbs',
          databaseURL: 'https://nutrition-app-flutter.firebaseio.com'));

  runApp(new MaterialApp(
    home: new Splash(),
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => new Home(app: app)
    },
  ));
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Splash!'),
      ),
    );
  }
}
