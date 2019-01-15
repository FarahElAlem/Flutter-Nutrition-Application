import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'package:nutrition_app_flutter/pages/search/details.dart';

import 'package:nutrition_app_flutter/structures/fooditem.dart';

/// TODO - Calories?
/// TODO - Search Bar?
/// TODO - Multiple queries based on keys?
/// TODO - Store locally?
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
//    print('TargetToken: ' + token);

    List<String> validKeys = [];
    ABBREVREF.forEach((str) {
//      print(str + ", " + token + ", " + str.contains(token.toUpperCase()).toString());
      if (str.contains(token.toUpperCase())) {
        validKeys.add(str);
      }
    });

//    print('Done Validating');
    return validKeys;
  }

  Future<Widget> _getSearchedResults() async {
    List<Widget> type1widget = [];
//    print('Num?: ' + validKeys.length.toString());

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
        ));
      });
    }

    return new ListView(
      children: type1widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready && type == 1) {
      return new Scaffold(
        appBar: new AppBar(),
        body: new Center(
          child: Text('Loading...'),
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
  ListItem({this.foodItem});

  FoodItem foodItem;

  @override
  State<StatefulWidget> createState() => new _ItemView(foodItem: foodItem);
}

class _ItemView extends State<ListItem> {
  _ItemView({this.foodItem});

  FoodItem foodItem;

  bool isAdd = true;

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
              icon: (isAdd) ? Icon(Icons.add) : Icon(Icons.remove),
              onPressed: () {
                isAdd = !isAdd;
                setState(() {});
              })
        ],
      ),
    );
  }
}
