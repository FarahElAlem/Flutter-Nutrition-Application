import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrition_app_flutter/pages/home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Main function. Gathers prerequisite information and starts the application.
Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _email = (prefs.getString('email') ?? '');
  String _password = (prefs.getString('password') ?? '');
  FirebaseUser currentUser = await signInWithFirestore(_email, _password);

  Firestore firestore = Firestore.instance;
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  runApp(new MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.green,
      cardColor: Colors.green,
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 32.0, fontFamily: 'Montserrat', color: Colors.white, fontWeight: FontWeight.w600),
        display1: TextStyle(fontSize: 32.0, fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.bold),
        subhead: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat', color: Colors.black),
        body1: TextStyle(fontSize: 18.0, fontFamily: 'OpenSans'),
        body2: TextStyle(fontSize: 18.0, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        caption: TextStyle(fontSize: 16.0, fontFamily: 'OpenSans', fontWeight: FontWeight.w600),
      )
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

/// Returns a splash screen
/// TODO Turn this into a logo
class SplashScreenAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
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
