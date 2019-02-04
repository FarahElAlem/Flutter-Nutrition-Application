import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:nutrition_app_flutter/pages/search/details.dart';
import 'package:nutrition_app_flutter/structures/fooditem.dart';

/// FoodGroupResult displays information regarding Cloud Firestore queries in a list like fashion.
/// FoodGroupResult has a token that specifics the search key, and a type that dictates the type of
/// ListItem displayed.
class FoodGroupResult extends StatefulWidget {
  FoodGroupResult({this.foodInformation, this.type, this.foodImage});

  int type;
  List<String> foodInformation;
  Image foodImage;

  List<dynamic> userNutrients;

  @override
  _FoodGroupResultState createState() => _FoodGroupResultState();
}

class _FoodGroupResultState extends State<FoodGroupResult> {
  bool _ready = false;
  var stream;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    doGathering();
  }

  /// Care Dairy
  List<String> _darkgroups = [
    'Breakfast Cereals',
    'Dairy and Egg Products',
    'Fats and Oils',
    'Lamb, Veal, and Game Products',
    'Snacks',
    'Soups, Sauces, and Gravies',
    'Fruits and Fruit Juices'
  ];

  /// Gathers the data needed to be displayed on this page before
  /// the page is 'ready'
  void doGathering() async {
    currentUser = await FirebaseAuth.instance.currentUser();

    if (!currentUser.isAnonymous) {
      Firestore.instance
          .collection('USERS')
          .document(currentUser.email)
          .get()
          .then((DocumentSnapshot snapshot) {
        widget.userNutrients =
            new List<dynamic>.from(snapshot.data['nutrients']);
      }).whenComplete(() {
        _ready = true;
        setState(() {});
      });
    } else {
      widget.userNutrients = new List();
      _ready = true;
      setState(() {});
    }
    stream = Firestore.instance
        .collection('ABBREV')
        .where('foodgroup', isEqualTo: widget.foodInformation[0])
        .limit(50)
        .snapshots();
    _ready = true;
  }

  /// Returns a loading screen widget
  /// TODO Make this global
  Widget _buildLoadingScreen() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(
              semanticsValue: 'Progress',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Loading...'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return new Scaffold(appBar: new AppBar(), body: _buildLoadingScreen());
    } else {
      return new Scaffold(
        body: LayoutBuilder (
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
                      new Positioned (
                          child: Hero (
                        tag: widget.foodInformation[0],
                        child: new AspectRatio(
                          aspectRatio: 16 / 8,
                          child: new Container(
                            decoration: new BoxDecoration(
                                image: new DecorationImage(
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.center,
                              image: widget.foodImage.image,
                            )),
                          ),
                        ),
                      )),
                      new AppBar (
                        iconTheme: IconThemeData(
                            color: (_darkgroups
                                    .contains(widget.foodInformation[1]))
                                ? Colors.black
                                : Colors.white),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: Text(widget.foodInformation[1], style: Theme.of(context).textTheme.headline,),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.black))),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
                            child: Center(
                              child: Text(widget.foodInformation[2], style: Theme.of(context).textTheme.caption,),
                            ))),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                    Text('Browse Items', style: Theme.of(context).textTheme.body2,),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                  ]),
                  StreamBuilder<QuerySnapshot> (
                    stream: stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return _buildLoadingScreen();
                        default:
                          return Column(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return new ListItem(
                                foodItem: new FoodItem(document),
                                userNutrients: widget.userNutrients,
                              );
                            }).toList(),
                          );
                      }
                    },
                  )
                ],
              ),
            ),
          );
        }),
      );
    }
  }
}

/// ListItem is a special ListTile that navigates to a new page of nutrition information on pressed.
class ListItem extends StatefulWidget {
  ListItem({this.foodItem, this.userNutrients});

  FoodItem foodItem;
  List<dynamic> userNutrients;

  @override
  State<StatefulWidget> createState() =>
      new _ItemView(foodItem: foodItem, userNutrients: userNutrients);
}

class _ItemView extends State<ListItem> {
  _ItemView({this.foodItem, this.userNutrients});

  FoodItem foodItem;
  FirebaseUser currentUser;
  List<dynamic> userNutrients;
  bool isFavorited;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      currentUser = user;
    });

    if (currentUser == null) {
      isFavorited = false;
    } else {
      if (userNutrients != null &&
          userNutrients.contains(
              foodItem.detailItems['ShortDescription']['value'].toString())) {
        isFavorited = true;
      } else {
        isFavorited = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 2.0,
      color: Colors.white,
      child: new ListTile(
        onTap: () async {
          /// onTap(): Navigate to a new Details page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoodGroupDetails(
                    foodItem: widget.foodItem,
                  )));
        },
        leading: Text(foodItem.detailItems['foodgroup']['value'], style: Theme.of(context).textTheme.caption,),
        title: Text(foodItem.detailItems['description']['value'], style: Theme.of(context).textTheme.caption,),
        trailing: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
                splashColor: (!isFavorited) ? Colors.amber : Colors.black12,
                icon: (!isFavorited)
                    ? Icon(
                  Icons.star,
                  color: Colors.grey,
                )
                    : Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onPressed: () async {
                  /// Checking to see if a user can favorite an item or not
                  /// If not, displays a snackbar
                  if (currentUser.isAnonymous) {
                    final snackbar = SnackBar(
                      content: Text('You must register before you can do that!', style: Theme.of(context).textTheme.body1,),
                      duration: Duration(milliseconds: 1500),
                      backgroundColor: Colors.green,
                    );
                    Scaffold.of(context).showSnackBar(snackbar);
                  }

                  /// If applicable, update the user's data in Cloud Firestore.
                  if (isFavorited && !currentUser.isAnonymous) {
                    isFavorited = false;
                    setState(() {});

                    var query = await Firestore.instance
                        .collection('USERS')
                        .document(currentUser.email)
                        .get();
                    Map<String, dynamic> data = query.data;

                    var nutrients = new List<String>.from(data['nutrients']);
                    nutrients.remove(
                        foodItem.detailItems['description']['value'].toString());

                    data['nutrients'] = nutrients;
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
                    Map<String, dynamic> data = query.data;

                    var nutrients = new List<String>.from(data['nutrients']);
                    nutrients.add(
                        foodItem.detailItems['description']['value'].toString());

                    data['nutrients'] = nutrients;
                    await Firestore.instance
                        .collection('USERS')
                        .document(currentUser.email)
                        .updateData(data);
                  }
                })
          ],
        ),
      ),
    );
  }
}
