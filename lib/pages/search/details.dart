import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search/foodgroupinfo.dart';
import 'package:nutrition_app_flutter/structures/encrypt.dart';
import 'package:nutrition_app_flutter/structures/fooditem.dart';

/// UI incomplete, details attempts to show nutrition details of some FoodItem
/// as a Dialog
class FoodGroupDetails extends StatefulWidget {
  FoodGroupDetails({this.foodItem});

  FoodItem foodItem;

  @override
  _FoodGroupDetailsState createState() => new _FoodGroupDetailsState();
}

class _FoodGroupDetailsState extends State<FoodGroupDetails> {
  bool _ready = false;
  bool isFavorited = false;
  FirebaseUser currentUser;
  var stream;

  /// Gathers the data needed to be displayed on this page before
  /// the page is 'ready'
  void doGathering() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser.isAnonymous) {
      isFavorited = false;
    } else {
      QuerySnapshot item = await Firestore.instance
          .collection('USERS')
          .document(Encrypt().encrypt(currentUser.email))
          .collection('NUTRIENTS')
          .where('description',
              isEqualTo: widget.foodItem.detailItems['description']['value'])
          .getDocuments();
      if (item.documents.length == 0) {
        isFavorited = false;
      } else {
        isFavorited = true;
      }
    }
    _ready = true;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    doGathering();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            new IconButton(
                splashColor: (!isFavorited) ? Colors.amber : Colors.black12,
                icon: (!isFavorited)
                    ? Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.amber,
                      ),
                onPressed: () async {
                  /// Checking to see if a user can favorite an item or not
                  /// If not, displays a snackbar
                  if (currentUser.isAnonymous) {
                    final snackbar = SnackBar(
                      content: Text(
                        'You must register before you can do that!',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      duration: Duration(milliseconds: 1500),
                      backgroundColor: Colors.green,
                    );
                    Scaffold.of(context).showSnackBar(snackbar);
                  }

                  /// If applicable, update the user's data in Cloud Firestore.
                  ///
                  /// Remove from Firestore
                  if (isFavorited && !currentUser.isAnonymous) {
                    isFavorited = false;
                    if (mounted) {
                      setState(() {});
                    }
                    await Firestore.instance
                        .collection("USERS")
                        .document(Encrypt().encrypt(currentUser.email))
                        .collection('NUTRIENTS')
                        .document(
                            widget.foodItem.detailItems['description']['value'])
                        .delete();
                  }

                  /// Add to Firestore
                  else if (!isFavorited && !currentUser.isAnonymous) {
                    isFavorited = true;
                    if (mounted) {
                      setState(() {});
                    }
                    await Firestore.instance
                        .collection("USERS")
                        .document(Encrypt().encrypt(currentUser.email))
                        .collection('NUTRIENTS')
                        .document(
                            widget.foodItem.detailItems['description']['value'])
                        .setData(widget.foodItem.toFirestore());
                  }
                })
          ]),
      body: (_ready)
          ? Container(
              child: widget.foodItem.buildListView(context),
            )
          : SplashScreenAuth(),
    );
  }
}

class SearchDetails extends StatefulWidget {
  SearchDetails({this.query});

  bool _loading = true;
  FirebaseUser currentUser;
  var userNutrients;

  void gatherData() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    userNutrients = (!currentUser.isAnonymous)
        ? await Firestore.instance
            .collection('USERS')
            .document(Encrypt().encrypt(currentUser.email))
            .collection('NUTRIENTS')
            .getDocuments()
        : null;
    _loading = false;
  }

  String query;

  @override
  State<StatefulWidget> createState() {
    gatherData();
    return new _SearchDetailsState();
  }
}

class _SearchDetailsState extends State<SearchDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (!widget._loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: new StreamBuilder(
                stream: Firestore.instance
                    .collection('ABBREV')
                    .orderBy('description')
                    .where('tokens', arrayContains: widget.query.toLowerCase())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SplashScreenAuth();
                  } else {
                    List<dynamic> verifiedDocs = new List();
                    var docs = snapshot.data.documents;
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
                              );
                            })
                        : Center(
                            child: Text('No Items Found',
                                style: Theme.of(context).textTheme.title),
                          );
                  }
                },
              ),
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
