import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'package:nutrition_app_flutter/pages/search/details.dart';
import 'package:nutrition_app_flutter/structures/fooditem.dart';

/// Result displays information regarding Cloud Firestore queries in a list like fashion.
/// Result has a token that specifics the search key, and a type that dictates the type of
/// ListItem displayed.
class Result extends StatefulWidget {
  Result({this.token, this.type});

  int type;
  String token;

  @override
  _ResultState createState() => _ResultState(token: token, type: type);
}

class _ResultState extends State<Result> {
  _ResultState({this.token, this.type});

  int type;
  String token;

  bool _ready = false;
  var stream;

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
  void initState() {
    super.initState();

    token = token.toUpperCase();

    if (type == 1) {
      stream = fdb
          .collection('ABBREV')
          .where('Shrt_Desc', isEqualTo: token)
          .snapshots();
    } else {
      stream = fdb
          .collection('ABBREV')
          .where('Fd_Grp', isEqualTo: token)
          .limit(100)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready && type == 1) {
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
                          type: 0,
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
  ListItem({this.foodItem, this.type});

  FoodItem foodItem;
  int type;

  @override
  State<StatefulWidget> createState() =>
      new _ItemView(foodItem: foodItem, type: type);
}

class _ItemView extends State<ListItem> {
  _ItemView({this.foodItem, this.type});

  FoodItem foodItem;
  int type;

  bool isAdd;

  @override
  void initState() {
    super.initState();
    isAdd = (type == 0) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () async {
        await showDialog(context: context, child: Details(foodItem: foodItem));
      },
      leading: new Text(foodItem.detailItems['FoodGroup']['value']),
      title: new Text(foodItem.detailItems['ShortDescription']['value']),
      trailing: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new IconButton(
              icon: (isAdd)
                  ? Icon(
                      Icons.star,
                      color: Colors.grey,
                    )
                  : Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
              onPressed: () {
                if (isAdd) {
                  isAdd = !isAdd;
                  SAVEDNUTRIENTS.add(this.foodItem);
                } else {
                  isAdd = !isAdd;
                  SAVEDNUTRIENTS.remove(this.foodItem);
                }
                setState(() {});
              })
        ],
      ),
    );
  }
}
