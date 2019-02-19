import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/recipe/itemwidget.dart';
import 'package:nutrition_app_flutter/actions/encrypt.dart';

/// UI incomplete, details attempts to show nutrition details of some FoodItem
/// as a Dialog
/// TODO Look at how the 'nutrients' and 'recipes' are being created
class Details extends StatefulWidget {
  Details({this.recipeItem});

  var recipeItem;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool _ready = false;
  bool isFavorited = false;
  FirebaseUser currentUser;
  var stream;

  Map<String, dynamic> data;

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
          .collection('RECIPES')
          .where('name', isEqualTo: widget.recipeItem['name'])
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
    data = widget.recipeItem.data;
    super.initState();
    doGathering();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
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
                      ),
                      duration: Duration(milliseconds: 1500),
                    );
//                    Scaffold.of(context).showSnackBar(snackbar);
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
                        .collection('RECIPES')
                        .document(widget.recipeItem['name'])
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
                        .collection('RECIPES')
                        .document(widget.recipeItem['name'])
                        .setData(data);
                  }
                })
          ],
        ),
        body: (!_ready)
            ? SplashScreenAuth()
            : LayoutBuilder(
                builder: (BuildContext contest, BoxConstraints constraintss) {
                return SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraintss.maxHeight),
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0),
                              child: Center(
                                child: Text(
                                  widget.recipeItem['name'],
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .headline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 25.0,
                          color: Colors.transparent,
                        ),
                        Hero(
                          tag: widget.recipeItem['name'],
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              widget.recipeItem['image'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        Divider(
                          height: 14.0,
                          color: Colors.transparent,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              widget.recipeItem['description'],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Ingredients',
                            style: Theme.of(context).accentTextTheme.subhead,
                          ),
                        ),
                        Container(
                          margin:
                          const EdgeInsets.only(left: 16.0),
                          child: Divider(
                            height: 2.0,
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.recipeItem['ingredients'].length,
                            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      widget.recipeItem['ingredients'][index],
                                      style: Theme.of(context)
                                          .accentTextTheme
                                          .body1,
                                    ),
                                  ),
                                ],
                              );
                            }),
                        Container(
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Directions',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                                  child: Divider(
                                    height: 2.0,
                                    color: Colors.white70,
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        widget.recipeItem['directions'].length,
                                    padding:
                                        EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        elevation: 3.0,
                                        child: ListTile(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              32.0, 8.0, 56.0, 8.0),
                                          leading: Text(
                                            (index + 1).toString(),
                                          ),
                                          title: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              widget.recipeItem['directions']
                                                  [index],
                                              style: Theme.of(context)
                                                  .accentTextTheme
                                                  .body1,
                                            ),
//                                alignment: Alignment(-80.0, 0),
                                          ),
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ),
                        )
                      ]),
                ));
              }));
  }
}

class SearchDetails extends StatefulWidget {
  SearchDetails({this.query});

  String query;

  @override
  _SearchDetailsState createState() => new _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
  List<Object> objs;

  bool _loading = true;

  void gatherData() async {
    var docs = await Firestore.instance.collection('RECIPES').getDocuments();

    objs = new List();

    docs.documents.forEach((DocumentSnapshot snapshot) {
      if (snapshot.data['name']
              .toString()
              .toLowerCase()
              .contains(widget.query) ||
          listContains(
              snapshot.data['ingredients'], widget.query.toLowerCase())) {
        objs.add(snapshot);
      }
    });
    _loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  bool listContains(List<dynamic> list, var query) {
    for (int i = 0; i < list.length; i++) {
      if (list[i]
          .toString()
          .toLowerCase()
          .contains(query..toString().toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    gatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Results For: ' + widget.query,
          style: Theme.of(context).textTheme.headline,
        ),
        centerTitle: true,
      ),
      body: (_loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemExtent: 130.0,
              padding: EdgeInsets.all(8.0),
              itemCount: objs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = objs[index];
                return ItemWidget(ds: ds);
              }),
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
