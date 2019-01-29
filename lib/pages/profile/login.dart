import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'package:nutrition_app_flutter/structures/validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.currentUser, this.firestore});

  Firestore firestore;
  FirebaseUser currentUser;

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
        title: getHeadingText('Login')
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(32.0),
            children: <Widget>[
              getHeadingText('Welcome Back!', TextAlign.center),
              Divider(
                color: Colors.transparent,
                height: 64.0,
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
                height: 64.0,
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
                height: 64.0,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        String s = await Validator().validateLoggedInUser(
                            _emailTextFieldController.text,
                            _passwordTextFieldController.text,
                            widget.firestore);
                        if (s != null) {
                          // this snackbar doesnt work, need to forward context key...
                          final snackbar = SnackBar(
                            content: getDetailsText(
                                'No account matching these credentials',
                                TextAlign.center),
                            backgroundColor: Colors.green,
                            duration: Duration(milliseconds: 1500),
                          );
                          Scaffold.of(context).showSnackBar(snackbar);
                        } else {
//                          FirebaseAuth.instance.signOut();
//                          widget.currentUser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextFieldController.text, password: _passwordTextFieldController.text);
                        }
                      }
                    },
                    child: getIconText('Login'),
                    color: Colors.green,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
