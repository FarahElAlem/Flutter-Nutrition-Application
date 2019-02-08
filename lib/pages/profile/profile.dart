import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/profile/nutrientitemwidget.dart';
import 'package:nutrition_app_flutter/pages/profile/recipeitemwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.firestore, this.currentUser, this.foodGroupUrls});

  Map<String, String> foodGroupUrls;

  Firestore firestore;
  FirebaseUser currentUser;

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _ready = false;

  DocumentSnapshot documentSnapshot;
  List<DocumentSnapshot> nutrientDocuments;
  List<DocumentSnapshot> recipesDocuments;

  @override
  void initState() {
    super.initState();
    gatherData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void gatherData() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

    documentSnapshot = await Firestore.instance
        .collection('USERS')
        .document(currentUser.email)
        .get();

    QuerySnapshot nutrientsSnapshot = await Firestore.instance
        .collection('USERS')
        .document(currentUser.email)
        .collection('NUTRIENTS')
        .getDocuments();

    nutrientDocuments = nutrientsSnapshot.documents;

    QuerySnapshot recipesSnapshot = await Firestore.instance
        .collection('USERS')
        .document(currentUser.email)
        .collection('RECIPES')
        .getDocuments();

    recipesDocuments = recipesSnapshot.documents;

    _ready = true;
    setState(() {});
  }

  Widget _buildLogoutButton() {
    return OutlineButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          await FirebaseAuth.instance.signInAnonymously();

          SharedPreferences.getInstance().then((SharedPreferences prefs) {
            prefs.setString('email', '');
            prefs.setString('password', '');
          });
        },
        child: Text(
          'Logout',
          style: Theme.of(context).textTheme.caption,
        ),
        color: Colors.green,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)));
  }

  @override
  Widget build(BuildContext context) {
    return (_ready)
        ? SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 28.0, left: 16.0, right: 16.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text(
                      documentSnapshot['name'] + '\'s Profile',
                      style: Theme.of(context).textTheme.display1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: ClipOval(
                        child: Image.asset(
                      'assets/images/profile_default.png',
                      fit: BoxFit.fill,
                      width: 128.0,
                      height: 128.0,
                    )),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 24.0,
                  ),
                  Text(
                    'Favorite Nutrients',
                    style: Theme.of(context).textTheme.subhead,
                    textAlign: TextAlign.start,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Container(
                    height: 180.0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemExtent: 160.0,
                        scrollDirection: Axis.horizontal,
                        itemCount: recipesDocuments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NutrientItemWidget(
                              ds: nutrientDocuments[index],
                              foodGroupUrls: widget.foodGroupUrls);
                        }),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 24.0,
                  ),
                  Text(
                    'Favorite Recipes',
                    style: Theme.of(context).textTheme.subhead,
                    textAlign: TextAlign.start,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Container(
                    height: 180.0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemExtent: 160.0,
                        scrollDirection: Axis.horizontal,
                        itemCount: recipesDocuments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RecipeItemWidget(ds: recipesDocuments[index]);
                        }),
                  ),
                  Center(
                    child: _buildLogoutButton(),
                  ),
                ],
              ),
            ),
          )
        : SplashScreenAuth();
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
