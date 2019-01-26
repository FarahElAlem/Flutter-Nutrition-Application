import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrition_app_flutter/globals.dart';

import 'package:nutrition_app_flutter/pages/search/details.dart';
import 'package:nutrition_app_flutter/structures/fooditem.dart';

/// Result displays information regarding Cloud Firestore queries in a list like fashion.
/// Result has a token that specifics the search key, and a type that dictates the type of
/// ListItem displayed.
class Result extends StatefulWidget {
  Result({this.token, this.type, this.currentUser, this.firestore});

  int type;
  String token;
  FirebaseUser currentUser;
  Firestore firestore;

  List<dynamic> userNutrients;

  @override
  _ResultState createState() => _ResultState(token: token, type: type);
}

class _ResultState extends State<Result> {
  _ResultState({this.token, this.type, this.userNutrients});

  int type;
  String token;

  bool _ready = false;
  var stream;

  List<dynamic> userNutrients;

  @override
  void initState() {
    super.initState();

    token = token.toUpperCase();

    if (widget.currentUser != null) {
      widget.firestore
          .collection('USERS')
          .document(widget.currentUser.email)
          .get()
          .then((DocumentSnapshot snapshot) {
        userNutrients = new List<dynamic>.from(snapshot.data['nutrients']);
      }).whenComplete(() {
        _ready = true;
        setState(() {});
      });
    } else {
      userNutrients = new List();
      _ready = true;
      setState(() {});
    }

    if (type == 1) {
      stream = Firestore.instance
          .collection('ABBREV')
          .where('Shrt_Desc', isEqualTo: token)
          .snapshots();
    } else {
      stream = Firestore.instance
          .collection('ABBREV')
          .where('Fd_Grp', isEqualTo: token)
          .limit(100)
          .snapshots();
    }
  }

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
      return new Scaffold(
        appBar: new AppBar(),
        body: _buildLoadingScreen(),
      );
    } else {
      return new Scaffold(
        appBar: new AppBar(),
        body: new Column(
          children: <Widget>[
            new Flexible(
                child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return _buildLoadingScreen();
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new ListItem(
                          foodItem: new FoodItem(document),
                          firestore: widget.firestore,
                          userNutrients: userNutrients,
                          currentUser: widget.currentUser,
                        );
                      }).toList(),
                    );
                }
              },
            ))
          ],
        ),
      );
    }
  }
}

/// Widget as a Stateful Widget
class ListItem extends StatefulWidget {
  ListItem(
      {this.foodItem, this.firestore, this.userNutrients, this.currentUser});

  FoodItem foodItem;
  Firestore firestore;
  List<dynamic> userNutrients;
  FirebaseUser currentUser;

  @override
  State<StatefulWidget> createState() =>
      new _ItemView(foodItem: foodItem, userNutrients: userNutrients);
}

class _ItemView extends State<ListItem> {
  _ItemView({this.foodItem, this.userNutrients});

  FoodItem foodItem;
  List<dynamic> userNutrients;
  bool isFavorited;

  @override
  void initState() {
    super.initState();

    if (widget.currentUser == null) {
      isFavorited = false;
    } else {
      if (userNutrients.contains(
          foodItem.detailItems['ShortDescription']['value'].toString())) {
        isFavorited = true;
      } else {
        isFavorited = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () async {
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => Details(foodItem: foodItem,)));
      },
      leading: getIconText(foodItem.detailItems['FoodGroup']['value']),
      title: getIconText(foodItem.detailItems['ShortDescription']['value']),
      trailing: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new IconButton(
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
                if (isFavorited && widget.currentUser != null) {
                  isFavorited = false;
                  setState(() {});

                  var query = await widget.firestore
                      .collection('USERS')
                      .document(widget.currentUser.email)
                      .get();
                  Map<String, dynamic> data = query.data;

                  var nutrients = new List<String>.from(data['nutrients']);
                  nutrients.remove(foodItem.detailItems['ShortDescription']
                          ['value']
                      .toString());

                  data['nutrients'] = nutrients;
                  await widget.firestore
                      .collection('USERS')
                      .document(widget.currentUser.email)
                      .updateData(data);
                } else if (!isFavorited && widget.currentUser != null) {
                  isFavorited = true;
                  setState(() {});

                  var query = await widget.firestore
                      .collection('USERS')
                      .document(widget.currentUser.email)
                      .get();
                  Map<String, dynamic> data = query.data;

                  var nutrients = new List<String>.from(data['nutrients']);
                  nutrients.add(foodItem.detailItems['ShortDescription']
                          ['value']
                      .toString());

                  data['nutrients'] = nutrients;
                  await widget.firestore
                      .collection('USERS')
                      .document(widget.currentUser.email)
                      .updateData(data);
                }
              })
        ],
      ),
    );
  }
}
