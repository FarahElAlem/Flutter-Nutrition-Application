import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'package:nutrition_app_flutter/pages/search/details.dart';

import 'package:nutrition_app_flutter/structures/fooditem.dart';

/// TODO - New Page upon click for further inspection?
/// TODO - Change IconButton to a different IconButton (Add and remove)
class Result extends StatefulWidget {
  Result({this.foodGroup});

  String foodGroup;

  @override
  _ResultState createState() => _ResultState(foodGroup: foodGroup);
}

class _ResultState extends State<Result> {
  _ResultState({this.foodGroup});

  String foodGroup;

  List<FoodItem> resultList = [];
  List<List<Object>> iconButtonList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Column(
        children: <Widget>[
          new Flexible(
              child: new FirebaseAnimatedList(
                  query: db
                      .reference()
                      .child('ABBREV')
                      .orderByChild('Fd_Grp')
                      .equalTo(foodGroup),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    final FoodItem foodItem = new FoodItem(snapshot.value);
                    return ListItem(
                      foodItem: foodItem,
                    );
                  }))
        ],
      ),
    );
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
      leading: new Text('NDB_No:\n' + foodItem.detailItems['FoodGroup']['value']),
      title: new Text(foodItem.detailItems['ShortDescription']['value']),
      trailing: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Card(
            color: (isAdd) ? Colors.lightGreen : Colors.red,
            child: new IconButton(
                icon: (isAdd) ? Icon(Icons.add) : Icon(Icons.remove),
                onPressed: () {
                  isAdd = !isAdd;
                  setState(() {});
                }),
          )
        ],
      ),
    );
  }
}
