import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/structures/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrition_app_flutter/pages/home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Main function. Gathers prerequisite information and starts the application.
Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _email = (Encrypt().decrypt(prefs.getString('email')) ?? '');
  String _password = (Encrypt().decrypt(prefs.getString('password')) ?? '');
  FirebaseUser currentUser = await signInWithFirestore(_email, _password);

  Firestore firestore = Firestore.instance;
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  runApp(new MaterialApp(
    theme: ThemeData(
      primaryColor: Color(0xFF4CAF50),
      primaryColorLight: Color(0xFFC8E6C9),
      primaryColorDark: Color(0xFF388E3C),
      backgroundColor: Color(0xFF000000),
      accentColor: Color(0xFFFFC107),
      dividerColor: Color(0xFFBDBDBD),
      textTheme: TextTheme(
          headline: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFFFFFFFF),
              fontSize: 48.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.0),
          subhead: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFFFFFFFF),
              fontSize: 34.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25),
          subtitle: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15),
          body1: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5),
          body2: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFFFFFFFF),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25),
          button: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFFFFFFFF),
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25),
          caption: TextStyle(
              fontFamily: 'Open Sans',
              color: Color(0xFFFFFFFF),
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4)),
      primaryTextTheme: TextTheme(
          headline: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFF212121),
              fontSize: 48.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.0),
          subhead: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFF212121),
              fontSize: 34.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25),
          subtitle: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFF212121),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15),
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
    home: new Home(
      currentUser: currentUser,
      firestore: firestore,
    ),
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => new Home()
    },
  ));
}

/// Helper function that signs a user into Firestore on application start
Future<FirebaseUser> signInWithFirestore(String email, String password) async {
  FirebaseUser user;
  if (email == '' || password == '') {
    print('Signing in Anon');
    user = await _auth.signInAnonymously();
  } else {
    print('Signing in w/ Email and PW');
    user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }
  return user;
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
