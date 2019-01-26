import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'result.dart';

/// class Search represents a Stateful widget that can have multiple states:
/// - Seeking / Searching:
///     - Consists of a StaggeredGridView of elements gathered from Firebase.
/// - Result Gathering
///     - Result of a query gathered from Firebase that users can interact with.
class Search extends StatefulWidget {
  Search({this.foodGroupNames, this.firestore, this.currentUser});

  Firestore firestore;
  FirebaseUser currentUser;
  List<List<String>> foodGroupNames;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Container(
          padding: EdgeInsets.all(8.0),
        ),
        new Expanded(
          child: new Container(
            padding: new EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 4.0),
            child: new StaggeredGridView.countBuilder(
              crossAxisCount: 3,
              itemCount: 24,
              itemBuilder: (BuildContext context, int index) => new InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => Result(
                                    token: widget.foodGroupNames[index][0],
                                    type: 0,
                                    currentUser: widget.currentUser,
                                    firestore: widget.firestore,
                                  )));
                    },
                    splashColor: Colors.transparent,
                    child: new Card(
                      color: Colors.blue,
                      child: new Center(
                          child: new Padding(
                        padding: EdgeInsets.all(8.0),
                        child: getMainContentText(widget.foodGroupNames[index][1], TextAlign.center),
                      )),
                    ),
                  ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(1, 1),
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
            ),
          ),
        )
      ],
    );
  }
}
