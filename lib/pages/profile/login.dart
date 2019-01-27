
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.firestore, this.currentUser});

  Firestore firestore;
  FirebaseUser currentUser;

  @override
  _LoginPageState createState() =>
      new _LoginPageState(currentUser: currentUser);
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState({this.currentUser});

  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  FirebaseUser currentUser;

  @override
  void dispose() {
    super.dispose();
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
  }

  void _handleAccountCreation(String email, String password) {
    _onLoading();
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((FirebaseUser firebaseUser) {
      currentUser = firebaseUser;

      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        prefs.setString('email', email);
        prefs.setString('password', password);
      });

      Map<String, Object> data = Map();
      data['email'] = email;
      data['password'] = password;
      data['nutrients'] = new List();
      data['recipes'] = new List();

      widget.firestore.collection('USERS').document(email).setData(data);
      Navigator.pop(context);
      setState(() {});
    });
  }

  void _onLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [new CircularProgressIndicator(), new Text('Loading')],
          );
        });
  }

  Widget _buildLoginPage() {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 36.0),
        child: Stack(
          children: <Widget>[
            Positioned(
                child: Align(
              alignment: FractionalOffset.topCenter,
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(
                  'Register With Us!',
                  style: TextStyle(fontSize: 28.0),
                ),
              ),
            )),
            Positioned(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _emailTextFieldController,
                      decoration: InputDecoration(hintText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _passwordTextFieldController,
                      decoration: InputDecoration(hintText: 'Password'),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: MaterialButton(
                      onPressed: () {
                        _handleAccountCreation(_emailTextFieldController.text,
                            _passwordTextFieldController.text);
                      },
                      child: Text('Register'),
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePage() {
    return ProfilePage(firestore: widget.firestore, currentUser: currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return (currentUser == null) ? _buildLoginPage() : _buildProfilePage();
  }
}
