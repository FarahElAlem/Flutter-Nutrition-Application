import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildUserInformationSection(),
          new Divider(
            height: 1.0,
          ),
          _buildSavedNutrientsSection(),
          new Divider(
            height: 1.0,
          ),
          _buildSavedRecipesSection()
        ],
      ),
    );
  }

}