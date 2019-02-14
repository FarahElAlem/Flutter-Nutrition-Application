import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/structures/encrypt.dart';
import 'package:nutrition_app_flutter/structures/validator.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// class LoginPage presents a form for a User
/// to log into Cloud Firestore, giving them the
/// ability to store and retrieve data from their personal
/// 'accounts'.
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override

  /// TODO Focus Nodes
  /// TODO Can use form.save instead of controllers... noted
  /// TODO REALLY LOOK AT FOCUS NODES
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).accentTextTheme.headline,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        String s = Validator().validateEmail(value);
                        if (s != null) {
                          return s;
                        }
                      },
                      controller: _emailTextFieldController,
                      style: Theme.of(context).accentTextTheme.body1,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.15),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Divider(
                      height: 28.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        String s = Validator().validatePassword(value);
                        if (s != null) {
                          return s;
                        }
                      },
                      controller: _passwordTextFieldController,
                      style: Theme.of(context).accentTextTheme.body1,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.15),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          String s = await Validator().validateLoggedInUser(
                              _emailTextFieldController.text,
                              _passwordTextFieldController.text);
                          if (s != null) {
                          print('Dobby is upset');
                          } else {
                            FirebaseUser user =
                                await FirebaseAuth.instance.currentUser();
                            await user.delete();
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _emailTextFieldController.text,
                                    password:
                                        _passwordTextFieldController.text);

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'email',
                                Encrypt()
                                    .encrypt(_emailTextFieldController.text));
                            prefs.setString(
                                'password',
                                Encrypt().encrypt(
                                    _passwordTextFieldController.text));

                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text(
                        'Login',
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
