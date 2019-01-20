import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'package:nutrition_app_flutter/pages/search/details.dart';

import 'package:nutrition_app_flutter/structures/fooditem.dart';

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

  Widget listView;

  bool _ready = false;

  List<FoodItem> resultList = [];
  List<List<Object>> iconButtonList = [];

  var query;
  List<String> validKeys;

  @override
  void initState() {
    super.initState();

    if (type == 1) {
      validKeys = _getValidKeys();
      _getSearchedResults().then((onValue) {
        listView = onValue;
        setState(() {
          _ready = true;
        });
      });
    }
    query = (type == 0)
        ? db.reference().child('ABBREV').orderByChild('Fd_Grp').equalTo(token)
        : null;
  }

  List<String> _getValidKeys() {
    List<String> validKeys = [];
    ABBREVREF.forEach((str) {
      if (str.contains(token.toUpperCase())) {
        validKeys.add(str);
      }
    });

    return validKeys;
  }

  Future<Widget> _getSearchedResults() async {
    List<Widget> type1widget = [];

    for (String key in validKeys) {
      await db
          .reference()
          .child('ABBREV')
          .orderByChild('Shrt_Desc')
          .equalTo(key)
          .once()
          .then((DataSnapshot snapshot) {
        String key = snapshot.value.entries.elementAt(0).key.toString();
        FoodItem foodItem = new FoodItem(snapshot.value[key]);
        type1widget.add(new ListItem(
          foodItem: foodItem,
          type: 0,
        ));
      });
    }

    return (validKeys.length == 0)
        ? new Center(
            child: Text(
              'Nothing of that criteria found!',
              textAlign: TextAlign.center,
            ),
          )
        : new ListView(
            children: type1widget,
          );
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready && type == 1) {
      return new Scaffold(
        appBar: new AppBar(),
        body: new Center(
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
        ),
      );
    } else {
      return new Scaffold(
        appBar: new AppBar(),
        body: new Column(
          children: <Widget>[
            new Flexible(
                child: (type == 0)
                    ? new FirebaseAnimatedList(
                        query: query,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          final FoodItem foodItem =
                              new FoodItem(snapshot.value);
                          return ListItem(
                            foodItem: foodItem,
                            type: 0,
                          );
                        })
                    : listView)
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
  State<StatefulWidget> createState() => new _ItemView(foodItem: foodItem, type: type);
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
              icon: (isAdd) ? Icon(Icons.star, color: Colors.grey,) : Icon(Icons.star, color: Colors.amber,),
              onPressed: () {
                if(isAdd) {
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
