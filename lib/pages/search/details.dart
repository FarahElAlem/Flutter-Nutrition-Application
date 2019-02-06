import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search/foodgroupresult.dart';
import 'package:nutrition_app_flutter/structures/fooditem.dart';

/// UI incomplete, details attempts to show nutrition details of some FoodItem
/// as a Dialog
class FoodGroupDetails extends StatelessWidget {
  FoodGroupDetails({this.foodItem});

  FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(foodItem.detailItems['description']['value'])),
      body: Container(
        child: foodItem.buildListView(context),
      ),
    );
  }
}

class SearchDetails extends StatefulWidget {
  SearchDetails({this.query});

  String query;

  @override
  _SearchDetailsState createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
  bool _loading = true;
  FirebaseUser currentUser;

  var userNutrients;

  @override
  void initState() {
    super.initState();
    gatherData();
  }

  void gatherData() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    userNutrients = (!currentUser.isAnonymous)
        ? await Firestore.instance
            .collection('USERS')
            .document(currentUser.email)
            .get()
        : null;
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (_loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new StreamBuilder(
              stream: Firestore.instance
                  .collection('ABBREV')
                  .orderBy('description')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SplashScreenAuth();
                } else {
                  List<dynamic> verifiedDocs = new List();
                  var docs = snapshot.data.documents;
                  print('docs.length: ' + docs.length.toString());
                  for (int i = 0; i < docs.length; i++) {
                    if (docs[i]['description']
                        .toString()
                        .toLowerCase()
                        .contains(widget.query.toLowerCase())) {
                      verifiedDocs.add(docs[i]);
                    }
                  }
                  return (verifiedDocs.length > 0)
                      ? new ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          itemCount: verifiedDocs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = verifiedDocs[index];
                            FoodItem foodItem = FoodItem(ds);
                            return new ListItem(
                              foodItem: foodItem,
                              userNutrients: userNutrients,
                            );
                          })
                      : Center(
                          child: Text('No Items Found', style: Theme.of(context).textTheme.title),
                        );
                }
              },
            ),
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
