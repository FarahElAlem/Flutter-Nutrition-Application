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
        primaryColor: Color.fromRGBO(0, 147, 118, 1.0),
        primaryColorLight: Color.fromRGBO(79, 196, 165, 1.0),
        primaryColorDark: Color.fromRGBO(0, 100, 74, 1.0),
        secondaryHeaderColor: Color.fromRGBO(178, 235, 242, 1.0),
        backgroundColor: Color.fromRGBO(245, 245, 246, 1.0),
        cardColor: Color.fromRGBO(235, 254, 245, 1.0),
        textTheme: TextTheme(
          headline: TextStyle(
              fontSize: 32.0, fontFamily: 'Roboto', color: Colors.white),
          display3: TextStyle(
            fontSize: 32.0, fontFamily: 'Roboto', color: Colors.black, fontWeight: FontWeight.w600),
          display1: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Roboto',
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
          display2: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Roboto',
            color: Colors.black,
          ),
          subhead: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Roboto',
            color: Colors.white,
          ),
          title: TextStyle(
              fontSize: 20.0, fontFamily: 'Roboto', color: Colors.white),
          body1: TextStyle(fontSize: 16.0, fontFamily: 'OpenSans'),
          body2: TextStyle(fontSize: 18.0, fontFamily: 'OpenSans'),
          caption: TextStyle(
              fontSize: 14.0,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              color: Colors.white),
          button: TextStyle(
              fontSize: 16.0,
              fontFamily: 'OpenSans',
              color: Colors.white,
          fontWeight: FontWeight.w400),
          subtitle: TextStyle(
            fontSize: 16.0,
            fontFamily: 'OpenSans',
            color: Colors.black,
            fontWeight: FontWeight.w600),
        )),
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
