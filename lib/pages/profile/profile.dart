import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/profile/nutrientitemwidget.dart';
import 'package:nutrition_app_flutter/pages/profile/recipeitemwidget.dart';
import 'package:nutrition_app_flutter/actions/encrypt.dart';
import 'package:nutrition_app_flutter/storage/usercache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.userCache});

  UserCache userCache;

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _ready = false;
  bool _loading = false;

  String name;

  DocumentSnapshot documentSnapshot;
  List<DocumentSnapshot> nutrientDocuments;
  List<DocumentSnapshot> recipesDocuments;

  void _gatherData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');

    if (mounted) {
      setState(() {
        _ready = true;
      });
    }
  }

  @override
  void initState() {
    _gatherData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildLogoutButton() {
    return OutlineButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          await FirebaseAuth.instance.signInAnonymously();

          SharedPreferences.getInstance().then((SharedPreferences prefs) {
            prefs.setString('email', '');
            prefs.setString('password', '');
            prefs.setString('name', '');
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
            padding: EdgeInsets.all(16.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Text(
                    name + '\'s Profile',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).accentTextTheme.headline,
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 24.0,
                ),
                Text(
                  'Favorite Nutrients',
                  textAlign: TextAlign.start,
                ),
                Divider(),
                (widget.userCache.getFavoriteNutrients().length > 0)
                    ? Container(
                        height: 180.0,
                        child: (!_loading)
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemExtent: 160.0,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.userCache
                                    .getFavoriteNutrients()
                                    .keys
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return NutrientItemWidget(
                                    ds: widget.userCache.getFavoriteNutrients()[
                                        widget.userCache
                                            .getFavoriteNutrients()
                                            .keys
                                            .toList()[index]],
                                    userCache: widget.userCache,
                                  );
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
                Divider(),
                (widget.userCache.getFavoriteRecipes().length > 0)
                    ? Container(
                        height: 180.0,
                        child: (!_loading)
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemExtent: 160.0,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.userCache
                                    .getFavoriteRecipes()
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return RecipeItemWidget(
                                    ds: widget.userCache.getFavoriteRecipes()[
                                        widget.userCache
                                            .getFavoriteRecipes()
                                            .keys
                                            .toList()[index]],
                                    userCache: widget.userCache,
                                  );
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
