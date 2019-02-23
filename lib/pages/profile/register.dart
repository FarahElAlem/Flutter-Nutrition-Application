import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/profile/login.dart';
import 'package:nutrition_app_flutter/pages/profile/profile.dart';
import 'package:nutrition_app_flutter/actions/encrypt.dart';
import 'package:nutrition_app_flutter/actions/validator.dart';
import 'package:nutrition_app_flutter/storage/usercache.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// class RegisterPage displays a page for the user to register with Firestore
/// If registered, the user can save and store data.
/// Can also navigate to a new 'login' page if the user already has an account.
class RegisterPage extends StatefulWidget {
  RegisterPage({this.userCache});

  final UserCache userCache;

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
  /// TODO CHECK IF ACCOUNT EXISTS AND THROW AN ERROR
  void _handleAccountCreation(
      String email, String password, String name) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await user.delete();
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('name', name);

    Map<String, Object> data = Map();
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;

    Firestore.instance.collection('USERS').document(email).setData(data);
  }

  /// Builds the page for the user to register with
  Widget _buildRegisterPage() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 32.0, right: 32.0),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Register\nWith Us!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).accentTextTheme.headline,
                ),
                Divider(
                  color: Colors.transparent,
                  height: 60.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        String s = Validator().validateName(value);
                        if (s != null) {
                          return s;
                        }
                      },
                      controller: _nameTextFieldController,
                      style: Theme.of(context).accentTextTheme.body1,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.15),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    Divider(
                      height: 28.0,
                      color: Colors.transparent,
                    ),
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
                      color: Colors.transparent,
                    ),
                    Container(
                      child: TextFormField(
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
                    ),
                  ],
                ),
                Divider(
                  color: Colors.transparent,
                  height: 60.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: OutlineButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            /// onPressed(): If the form is valid, handle new user register
                            if (_formKey.currentState.validate()) {
                              _handleAccountCreation(
                                  _emailTextFieldController.text,
                                  _passwordTextFieldController.text,
                                  _nameTextFieldController.text);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Creating New Account')));
                            }
                          },
                          child: Text(
                            'Register',
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              height: 36,
                            )),
                      ),
                      Text(
                        'OR',
                      ),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
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
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            'Already Have An Account?',
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

  /// Builds the person's profile page
  Widget _buildProfilePage() {
    return ProfilePage(userCache: widget.userCache);
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
          } else {
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
