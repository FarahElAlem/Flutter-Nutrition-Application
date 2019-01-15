import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'package:nutrition_app_flutter/pages/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

/// Load data from config files and setup necessary items
/// including the Firebase database connection.
Future<void> main() async {
  String data = await rootBundle.loadString('assets/config.json');
  var jsonData = json.decode(data);

  final FirebaseApp app = await FirebaseApp.configure(
      name: 'db2',
      options: FirebaseOptions(
          googleAppID: jsonData['googleAppID'].toString(),
          apiKey: jsonData['apiKey'].toString(),
          databaseURL: jsonData['databaseURL'].toString()));

  db = FirebaseDatabase.instance;

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

/// We create an async starTime() function that prelaods some global variables
/// from the FireBase database
class _SplashState extends State<Splash> {
  startTime() async {
    await db
        .reference()
        .child('FOODGROUP')
        .once()
        .then((DataSnapshot snapshot) {
      for (var value in snapshot.value) {
        FOODGROUPNAMES.add([value['Fd_Grp'], value['FdGrp_Desc']]);
      }
    });

    navigationPage();
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
    SCREENWIDTH = MediaQuery.of(context).size.width;
    SCREENHEIGHT = MediaQuery.of(context).size.height;

    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              semanticsValue: 'Progress',
            ),
            Padding(
              padding: EdgeInsets.all(40.0),
              child: Text('Loading...'),
            )
          ],
        ),
      ),
    );
  }
}
