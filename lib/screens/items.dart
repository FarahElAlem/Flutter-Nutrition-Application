import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Items extends StatelessWidget {
  Items({this.database});

  final FirebaseDatabase database;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new FirebaseAnimatedList(
                query: FirebaseDatabase.instance
                    .reference()
                    .child('ABBREV')
                    .orderByChild('Shrt_Desc')
                    .equalTo('BUTTER,WITH SALT'),
                padding: const EdgeInsets.all(8.0),
                reverse: false,
                itemBuilder: (_, DataSnapshot snapshot,
                    Animation<double> animation, int x) {
                  return fireBaseListTile(snapshot);
                }),
          )
        ],
      ),
    );
  }
}

Widget fireBaseListTile(DataSnapshot snapshot) {
  return new ListTile(
    title: Text(snapshot.value['Shrt_Desc'].toString()),
    subtitle: Text('NDB NUMBER: ' + snapshot.value['NDB_No'].toString()),
  );
}
