import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/profile/nutrientitemwidget.dart';
import 'package:nutrition_app_flutter/pages/profile/recipeitemwidget.dart';
import 'package:nutrition_app_flutter/structures/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.firestore, this.currentUser, this.foodGroupDetails});

  Map<String, dynamic> foodGroupDetails;

  Firestore firestore;
  FirebaseUser currentUser;

  @override
  _ProfilePageState createState() => new _ProfilePageState(
      firestore: firestore,
      currentUser: currentUser,
      foodGroupDetails: foodGroupDetails);
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState({this.firestore, this.currentUser, this.foodGroupDetails});

  Map<String, dynamic> foodGroupDetails;
  Firestore firestore;
  FirebaseUser currentUser;

  bool _ready = false;
  bool _loading = false;

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
        .document(Encrypt().encrypt(currentUser.email))
        .get();
    _ready = true;

    QuerySnapshot nutrientsSnapshot = await Firestore.instance
        .collection('USERS')
        .document(Encrypt().encrypt(currentUser.email))
        .collection('NUTRIENTS')
        .getDocuments();

    nutrientDocuments = nutrientsSnapshot.documents;

    QuerySnapshot recipesSnapshot = await Firestore.instance
        .collection('USERS')
        .document(Encrypt().encrypt(currentUser.email))
        .collection('RECIPES')
        .getDocuments();

    recipesDocuments = recipesSnapshot.documents;

    _loading = true;
    if (mounted) {
      setState(() {});
    }
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
        ),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)));
  }

  @override
  Widget build(BuildContext context) {
    return (_ready)
        ? Container(
            child: Padding(
              padding: EdgeInsets.only(top: 28.0, left: 16.0, right: 16.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text(
                      Encrypt().decrypt(documentSnapshot['name']) +
                          '\'s Profile',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(
                    height: 24.0,
                  ),
                  Text(
                    'Favorite Nutrients',
                    textAlign: TextAlign.start,
                  ),
                  Divider(
                  ),
                  (nutrientDocuments.length > 0)
                      ? Container(
                          height: 180.0,
                          child: (_loading)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemExtent: 160.0,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: nutrientDocuments.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return NutrientItemWidget(
                                        ds: nutrientDocuments[index],
                                        foodGroupDetails: foodGroupDetails);
                                  })
                              : SplashScreenAuth(),
                        )
                      : Center(
                          child: Text(
                            'Nothing Here Yet!\nGo Add Some Nutrients!',
                            textAlign: TextAlign.center,
                          ),
                        ),
                  Divider(
                    height: 24.0,
                  ),
                  Text(
                    'Favorite Recipes',
                    textAlign: TextAlign.start,
                  ),
                  Divider(
                  ),
                  (recipesDocuments.length > 0)
                      ? Container(
                          height: 180.0,
                          child: (_loading)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemExtent: 160.0,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recipesDocuments.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return RecipeItemWidget(
                                        ds: recipesDocuments[index]);
                                  })
                              : SplashScreenAuth(),
                        )
                      : Center(
                          child: Text(
                            'Nothing Here Yet!\nGo Add Some Recipes!',
                            textAlign: TextAlign.center,
                          ),
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
