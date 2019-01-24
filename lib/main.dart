import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'package:nutrition_app_flutter/pages/home.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:nutrition_app_flutter/structures/fooditem.dart';

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

  fdb = Firestore.instance;
  fdb.settings(timestampsInSnapshotsEnabled: true);

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
    await fdb
        .collection('FOODGROUP')
        .getDocuments()
        .then((data) => data.documents.forEach((doc) {
              FOODGROUPNAMES.add([doc['Fd_Grp'], doc['FdGrp_Desc']]);
            }));
    print(FOODGROUPNAMES.toString());

    String data = await rootBundle.loadString('assets/testnutrients.json');
    var jsonData = json.decode(data);
    jsonData = jsonData['payload'];
    for (var v in jsonData) {
      FoodItem f = new FoodItem(v);
      SAVEDNUTRIENTS.add(f);
    }

    data = await rootBundle.loadString('assets/testrecipes.json');
    jsonData = json.decode(data);
    SAVEDRECIPES = jsonData['payload'];

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
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              semanticsValue: 'Progress',
            ),
            new Padding(
              padding: EdgeInsets.all(40.0),
              child: Text('Loading...'),
            )
          ],
        ),
      ),
    );
  }
}
