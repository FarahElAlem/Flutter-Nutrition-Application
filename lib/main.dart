import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:NutriAssistant/pages/home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Main function. Gathers prerequisite information and starts the application.
Future<void> main() async {
  Firestore firestore = Firestore.instance;
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  runApp(new MaterialApp(
    title: "NutriAssistant",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(0xFF4CAF50),
      primaryColorLight: Color(0xFFC8E6C9),
      primaryColorDark: Color(0xFF388E3C),
      backgroundColor: Color(0xFF000000),
      accentColor: Color(0xFFE040FB),
      dividerColor: Color(0xFFBDBDBD),
      textTheme: TextTheme(
          headline: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFFFFFFFF),
              fontSize: 34.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25),
          subhead: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFFFFFFFF),
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.0),
          title: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15),
          subtitle: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFF212121),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.1),
          body1: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFF212121),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5),
          body2: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFF757575),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25),
          button: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFF212121),
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25),
          caption: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFF757575),
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4)),
      accentTextTheme: TextTheme(
          headline: TextStyle(
              fontFamily: 'Lobster',
              color: Color(0xFF212121),
              fontSize: 48.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25),
          subhead: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFF212121),
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.0),
          title: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFF212121),
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15),
          subtitle: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFF212121),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.1),
          body1: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFF212121),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5),
          body2: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFF757575),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25),
          button: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFF212121),
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25),
          caption: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFF757575),
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4)),
    ),
    home: new Home(),
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => new Home()
    },
  ));
}

/// Debug screen for error testing
/// TODO Remove from final build
class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: new Center(
        child: Text('Error'),
      ),
    );
  }
}
