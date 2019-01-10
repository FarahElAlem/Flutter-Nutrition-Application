import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Items extends StatelessWidget {
  Items({this.database});

  final FirebaseDatabase database;

  bool _gathering = false;

  Widget firebaseAnimatedList() {

//    setState(() {
//      _gathering = true;
//    });

    Widget firebaseAnimatedList = new FirebaseAnimatedList(
        query: FirebaseDatabase.instance
            .reference()
            .child('ABBREV')
            .orderByChild('Energ_Kcal')
            .equalTo(717),
        padding: const EdgeInsets.all(8.0),
        reverse: false,
        itemBuilder:
            (_, DataSnapshot snapshot, Animation<double> animation, int x) {
          return firebaseListTile(snapshot);
        });

    return firebaseAnimatedList;
  }

  Widget firebaseListTile(DataSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: new ListTile(
          title: Text(snapshot.value['Shrt_Desc'].toString()),
          subtitle: Text('NDB NUMBER: ' + snapshot.value['NDB_No'].toString()),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: firebaseAnimatedList(),
          )
        ],
      ),
    );
  }
}
