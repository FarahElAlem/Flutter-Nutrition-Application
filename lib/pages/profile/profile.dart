import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.firestore, this.currentUser});

  Firestore firestore;
  FirebaseUser currentUser;

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildSavedNutrientsSection() {
    return new Text('Saved Nutrients');
  }

  Widget _buildSavedRecipesSection() {
    return new Text('Saved Recipes');
  }

  Widget _buildUserInformationSection() {
    return new Text('User Info');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          OutlineButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await FirebaseAuth.instance.signInAnonymously();

                SharedPreferences.getInstance().then((SharedPreferences prefs) {
                  prefs.setString('email', '');
                  prefs.setString('password', '');
                  prefs.setString('name', '');
                });

              },
              child: Text('Logout', style: Theme.of(context).textTheme.caption,),
              color: Colors.green,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)))
        ],
      ),
    );
  }
}
