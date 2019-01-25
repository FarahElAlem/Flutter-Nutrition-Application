import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nutrition_app_flutter/pages/home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> main() async {
  bool hasAccount;
  var userdata;
  String filedata = await readFile();
  if(filedata != null) {
    userdata = json.decode(filedata);
    if (userdata['email'] == '') {
      hasAccount = false;
    } else {
      hasAccount = true;
    }
  } else {
    userdata = null;
  }

  runApp(new MaterialApp(
    home: _getLandingPage(userdata, hasAccount),
    routes: <String, WidgetBuilder>{
      '/Home': (BuildContext context) => new Home()
    },
  ));
}

Future<String> get _localPath async {
  final directory = await getTemporaryDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  File file = File('$path/assets/userdata.json');
  return (file == null) ? file.create() : file;
}

/// Figure out how to store locally on file system.
/// TODO https://pub.dartlang.org/packages/sqflite
Future<String> readFile() async {
  final file = await _localFile;
  return file.readAsString();
}

Widget _getLandingPage(var userdata, bool hasAccount) {
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
    if (userdata == null) {
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
