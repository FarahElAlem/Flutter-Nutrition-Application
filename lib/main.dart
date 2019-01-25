import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrition_app_flutter/pages/home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> main() async {  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _email = (prefs.getString('email') ?? '');
  String _password = (prefs.getString('password') ?? '');
  bool hasAccount = (_email == '') ?  false : true;

  await signInWithFirestore(_email, _password);

  runApp(new MaterialApp(
    home: _getLandingPage(_email, _password, hasAccount),
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => new Home()
    },
  ));
}

Future<FirebaseUser> signInWithFirestore(String email, String password) async {
  FirebaseUser user;
  if (email == '') {
    user = await _auth.signInAnonymously();
  } else {
    user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }
  return user;
}

Widget _getLandingPage(String email, String password, bool hasAccount) {
  return StreamBuilder<FirebaseUser>(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return new SplashScreenAuth();
      } else {
        if (snapshot.hasData) {
          return new Home(
            hasAccount: hasAccount,
          );
        } else {
        }
      }
    },
  );
}

class SplashScreenAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
