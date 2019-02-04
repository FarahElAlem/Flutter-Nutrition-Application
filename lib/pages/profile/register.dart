import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/profile/login.dart';
import 'package:nutrition_app_flutter/pages/profile/profile.dart';
import 'package:nutrition_app_flutter/structures/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nutrition_app_flutter/globals.dart';

/// class RegisterPage displays a page for the user to register with Firestore
/// If registered, the user can save and store data.
/// Can also navigate to a new 'login' page if the user already has an account.
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final _nameTextFieldController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    _nameTextFieldController.dispose();
  }

  /// Creates an account with Firestore if it doesn't exist
  void _handleAccountCreation(String email, String password, String name) async {
    _onLoading();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await user.delete();
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('name', name);

    Map<String, Object> data = Map();
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['nutrients'] = new List();
    data['recipes'] = new List();

    Firestore.instance.collection('USERS').document(email).setData(data);
    Navigator.pop(context);
  }

  void _onLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new CircularProgressIndicator(),
                  new Text('Loading')
                ],
              )
            ],
          );
        });
  }

  /// Builds the page for the user to register with
  Widget _buildRegisterPage() {
    return Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(20.0),
            shrinkWrap: true,
            children: <Widget>[
              getHeadingText('Register With Us!', textAlign: TextAlign.center),
              Divider(
                color: Colors.transparent,
                height: 16.0,
              ),
              getDetailsText(
                  'Then you can save your favorite\nrecipes & nutrients on your phone!',
                  textAlign: TextAlign.center),
              Divider(
                color: Colors.transparent,
                height: 56.0,
              ),
              TextFormField(
                validator: (value) {
                  String s = Validator().validateName(value);
                  if (s != null) {
                    return s;
                  }
                },
                controller: _nameTextFieldController,
                decoration: InputDecoration(hintText: 'Name'),
                keyboardType: TextInputType.text,
              ),
              Divider(
                color: Colors.transparent,
                height: 12.0,
              ),
              TextFormField(
                validator: (value) {
                  String s = Validator().validateEmail(value);
                  if (s != null) {
                    return s;
                  }
                },
                controller: _emailTextFieldController,
                decoration: InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              Divider(
                color: Colors.transparent,
                height: 12.0,
              ),
              TextFormField(
                validator: (value) {
                  String s = Validator().validatePassword(value);
                  if (s != null) {
                    return s;
                  }
                },
                controller: _passwordTextFieldController,
                decoration: InputDecoration(hintText: 'Password'),
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              Divider(
                color: Colors.transparent,
                height: 36.0,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                    onPressed: () {
                      /// onPressed(): If the form is valid, handle new user register
                      if (_formKey.currentState.validate()) {
                        _handleAccountCreation(
                          _emailTextFieldController.text,
                          _passwordTextFieldController.text,
                          _nameTextFieldController.text);
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Creating New Account')));
                      }
                    },
                    child: getIconText('Register'),
                    color: Colors.green,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                getDetailsText('OR'),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: getIconText('Already Have An Account?'),
                    color: Colors.green,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              )
            ],
          ),
        ));
  }

  /// Builds the person's profile page
  Widget _buildProfilePage() {
    return ProfilePage();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new SplashScreenAuth();
        } else {
          if (snapshot.hasData && !snapshot.data.isAnonymous) {
            return _buildProfilePage();
          } else if (snapshot.hasData && snapshot.data.isAnonymous) {
            return _buildRegisterPage();
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}

/// Splash Screen
/// TODO Make a global splash screen
class SplashScreenAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
