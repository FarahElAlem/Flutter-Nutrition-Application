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
      primaryColorDark: Color.fromRGBO(153, 204, 96, 1.0),
      primaryColorLight: Color.fromRGBO(255, 255, 194, 1.0),
      primaryColor: Color.fromRGBO(204, 255, 144, 1.0),
      backgroundColor: Color.fromRGBO(245, 245, 246, 1.0),
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 32.0, fontFamily: 'Montserrat', color: Colors.white, fontWeight: FontWeight.w600),
        display1: TextStyle(fontSize: 32.0, fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.bold),
        display2: TextStyle(fontSize: 28.0, fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.bold),
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
