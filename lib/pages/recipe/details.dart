import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/recipe/itemwidget.dart';

/// UI incomplete, details attempts to show nutrition details of some FoodItem
/// as a Dialog
class Details extends StatefulWidget {
  Details({this.recipeItem});

  var recipeItem;
  List<dynamic> userRecipes;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool _ready = false;
  bool isFavorited = false;
  FirebaseUser currentUser;
  var stream;

  /// Gathers the data needed to be displayed on this page before
  /// the page is 'ready'
  void doGathering() async {
    currentUser = await FirebaseAuth.instance.currentUser();

    if (!currentUser.isAnonymous) {
      DocumentSnapshot documentSnapshot = await Firestore.instance
          .collection('USERS')
          .document(currentUser.email)
          .get();

      if (documentSnapshot.data != null) {
        widget.userRecipes =
            new List<dynamic>.from(documentSnapshot.data['recipes']);
      } else {
        widget.userRecipes = new List();
      }
    } else {
      widget.userRecipes = new List();
    }
    stream = Firestore.instance
        .collection('RECIPES')
        .where('name', isEqualTo: widget.recipeItem['name'])
        .snapshots();

    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      currentUser = user;
    });

    if (currentUser == null) {
      isFavorited = false;
    } else {
      if (widget.userRecipes != null &&
          widget.userRecipes.contains(widget.recipeItem['name'])) {
        isFavorited = true;
      } else {
        isFavorited = false;
      }
    }
    _ready = true;
    setState(() {
    });
  }

  @override
  void initState() {
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
//                    final snackbar = SnackBar(
//                      content: Text(
//                        'You must register before you can do that!',
//                        style: Theme.of(context).textTheme.body1,
//                      ),
//                      duration: Duration(milliseconds: 1500),
//                      backgroundColor: Colors.green,
//                    );
//                    Scaffold.of(context).showSnackBar(snackbar);
//                    Scaffold.of() called with a context that does not contain a Scaffold.
//                    E/flutter (15381): No Scaffold ancestor could be found starting from the context that was passed to Scaffold.of(). This usually happens when the context provided is from the same StatefulWidget as that whose build function actually creates the Scaffold widget being sought.
//                  E/flutter (15381): There are several ways to avoid this problem. The simplest is to use a Builder to get a context that is "under" the Scaffold. For an example of this, please see the documentation for Scaffold.of():
//                  E/flutter (15381):   https://docs.flutter.io/flutter/material/Scaffold/of.html
//                  E/flutter (15381): A more efficient solution is to split your build function into several widgets. This introduces a new context from which you can obtain the Scaffold. In this solution, you would have an outer widget that creates the Scaffold populated by instances of your new inner widgets, and then in these inner widgets you would use Scaffold.of().
//                  E/flutter (15381): A less elegant but more expedient solution is assign a GlobalKey to the Scaffold, then use the key.currentState property to obtain the ScaffoldState rather than using the Scaffold.of() function.
                  }

                  /// If applicable, update the user's data in Cloud Firestore.
                  if (isFavorited && !currentUser.isAnonymous) {
                    isFavorited = false;
                    setState(() {});

                    var query = await Firestore.instance
                        .collection('USERS')
                        .document(currentUser.email)
                        .get();
                    Map<String, dynamic> data = (query.data == null) ? new Map() : query.data;
                    var recipes;
                    if(data.keys.length > 0)
                      recipes = new List<String>.from(data['recipes']);
                    else
                      recipes = new List<String>();
                    recipes.remove(widget.recipeItem['name']);

                    data['recipes'] = recipes;
                    await Firestore.instance
                        .collection('USERS')
                        .document(currentUser.email)
                        .updateData(data);
                  } else if (!isFavorited && !currentUser.isAnonymous) {
                    isFavorited = true;
                    setState(() {});

                    var query = await Firestore.instance
                        .collection('USERS')
                        .document(currentUser.email)
                        .get();
                    Map<String, dynamic> data = (query.data == null) ? new Map() : query.data;

                    var recipes;
                    if(data.keys.length > 0)
                      recipes = new List<String>.from(data['recipes']);
                    else
                      recipes = new List<String>();
                    recipes.add(widget.recipeItem['name']);

                    data['recipes'] = recipes;
                    await Firestore.instance
                        .collection('USERS')
                        .document(currentUser.email)
                        .updateData(data);
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
                  constraints:
                      BoxConstraints(minHeight: constraintss.maxHeight),
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
                                  style: Theme.of(context).textTheme.display1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.transparent,
                          height: 25.0,
                        ),
                        Hero(
                          tag: widget.recipeItem['image'],
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
                          color: Colors.transparent,
                          height: 14.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              widget.recipeItem['description'],
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Ingredients',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            height: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.recipeItem['ingredients'].length,
                            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      widget.recipeItem['ingredients'][index],
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                                  ),
                                ],
                              );
                            }),
                        Container(
                          color: Color.fromRGBO(76, 175, 80, 0.2),
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
                                    style: Theme.of(context).textTheme.subhead,
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
                                        color: Colors.white,
                                        child: ListTile(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              32.0, 8.0, 56.0, 8.0),
                                          leading: Text(
                                            (index + 1).toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2,
                                          ),
                                          title: Align(
                                            child: Text(
                                              widget.recipeItem['directions']
                                                  [index],
                                              style: Theme.of(context)
                                                  .textTheme
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
    setState(() {});
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
