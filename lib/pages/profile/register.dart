import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/profile/login.dart';
import 'package:nutrition_app_flutter/pages/profile/profile.dart';
import 'package:nutrition_app_flutter/structures/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nutrition_app_flutter/globals.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({this.firestore, this.currentUser});

  Firestore firestore;
  FirebaseUser currentUser;

  @override
  _RegisterPageState createState() =>
      new _RegisterPageState(currentUser: currentUser);
}

class _RegisterPageState extends State<RegisterPage> {
  _RegisterPageState({this.currentUser});

  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final _nameTextFieldController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FirebaseUser currentUser;

  @override
  void dispose() {
    super.dispose();
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    _nameTextFieldController.dispose();
  }

  /// TODO Check if account already exists...
  void _handleAccountCreation(String email, String password, String name) {
    _onLoading();
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((FirebaseUser firebaseUser) {
      currentUser = firebaseUser;

      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        prefs.setString('email', email);
        prefs.setString('password', password);
        prefs.setString('name', name);
      });

      Map<String, Object> data = Map();
      data['email'] = email;
      data['password'] = password;
      data['name'] = name;
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

  /// TODO Focus Nodes
  /// TODO Dynamic Padding
  Widget _buildRegisterPage() {
    return Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(20.0),
            shrinkWrap: true,
            children: <Widget>[
              getHeadingText('Register With Us!', TextAlign.center),
              Divider(
                color: Colors.transparent,
                height: 8.0,
              ),
              getDetailsText(
                  'Then you can save your favorite\nrecipes & nutrients on your phone!',
                  TextAlign.center),
              Divider(
                color: Colors.transparent,
                height: 36.0,
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
                      if (_formKey.currentState.validate()) {
//                        _handleAccountCreation(
//                          _emailTextFieldContro ller.text,
//                          _passwordTextFieldController.text,
//                          _nameTextFieldController.text);
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage(
                                    currentUser: widget.currentUser,
                                    firestore: widget.firestore,
                                  )));
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

  Widget _buildProfilePage() {
    return ProfilePage(firestore: widget.firestore, currentUser: currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return (currentUser == null || currentUser.isAnonymous)
        ? _buildRegisterPage()
        : _buildProfilePage();
  }
}
