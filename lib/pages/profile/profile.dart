import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search/result.dart';

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
    return new ListView.builder(itemBuilder: (BuildContext context, int index) {
      var snapshots = widget.firestore.collection('USERS').document(widget.currentUser.email).snapshots();
      return new ListItem();
    });
  }

  Widget _buildSavedRecipesSection() {
    return null;
  }

  Widget _buildUserInformationSection() {
    return null;
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