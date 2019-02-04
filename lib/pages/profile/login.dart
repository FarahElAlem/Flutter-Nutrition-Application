import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/structures/validator.dart';

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
        title: Text('Login', style: Theme.of(context).textTheme.headline,)
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(32.0),
            children: <Widget>[
              Text('Welcome Back!', style: Theme.of(context).textTheme.headline,),
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
                            _passwordTextFieldController.text);
                        if (s != null) {
                          print('Dobby is upset');
                        } else {
                          FirebaseUser user = await FirebaseAuth.instance.currentUser();
                          await user.delete();
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextFieldController.text, password: _passwordTextFieldController.text);
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text('Login', style: Theme.of(context).textTheme.caption,),
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
