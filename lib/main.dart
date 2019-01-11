import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/home.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:path_provider/path_provider.dart';

/// Load data from config files and setup necessary items
/// including the Firebase database connection.
Future<void> main() async {
//  String googleAppId;
//  String apiKey;
//  String databaseURL;
//
//  final Directory directory = await getApplicationDocumentsDirectory();
//  final path = directory.path;
//  print(path);
//  new File('/src/config.json')
//      .readAsString()
//      .then((fileContents) => json.decode(fileContents))
//      .then((jsonData) {
//        print('data: ' + jsonData.toString());
//    googleAppId = jsonData['googleAppId'];
//    apiKey = jsonData['apiKey'];
//    databaseURL = jsonData['databaseURL'];
//  });

  final FirebaseApp app = await FirebaseApp.configure(
      name: 'db2',
      options: FirebaseOptions(
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

/// Before the app is loaded, a logo splash screen is displayed.
/// Note: Setup should be done during this time, and once it is complete the
/// screen should vanish (such as loading the database, setting up final globals, etc.
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
