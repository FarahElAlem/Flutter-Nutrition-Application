import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nutrition_app_flutter/pages/home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() {
  runApp(new MaterialApp(
    home: _getLandingPage(),
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => new Home()
    },
  ));
}

String getFileData(String path) {
  rootBundle.loadString(path).then((String str) {
    return str;
  });
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

/// TODO Do this stuff
Widget _getLandingPage() {
  String filedata;
  var userdata = json.decode(filedata);

  bool hasAccount;
  if (userdata['email'] == '') {
    hasAccount = false;
  } else {
    hasAccount = true;
  }

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
          return LoginPage(userdata: userdata);
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

class LoginPage extends StatelessWidget {
  LoginPage({this.userdata});

  var userdata;

  Future<FirebaseUser> signInWithFirestore() async {
    FirebaseUser user;
    if (userdata['email'] == '') {
      user = await _auth.signInAnonymously();
    } else {
      user = await _auth.signInWithEmailAndPassword(
          email: userdata['email'], password: userdata['password']);
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            signInWithFirestore();
          },
          color: Colors.purple,
          child: Text('Login!'),
        ),
      ),
    );
  }
}
