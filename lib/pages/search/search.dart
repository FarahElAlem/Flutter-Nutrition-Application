import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nutrition_app_flutter/pages/search/result.dart';

/// class Search represents a Stateful widget that can have multiple states:
/// - Seeking / Searching:
///     - Consists of a StaggeredGridView of elements gathered from Firebase.
/// - Result Gathering
///     - Result of a query gathered from Firebase that users can interact with.
class Search extends StatefulWidget {
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
              crossAxisCount: 4,
              itemCount: 24,
              itemBuilder: (BuildContext context, int index) => new InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Result(
                                    token: FOODGROUPNAMES[index][0],
                                    type: 0,
                                  )));
                    },
                    splashColor: Colors.transparent,
                    child: new Card(
                      color: Colors.lightGreen,
                      child: new Center(
                          child: new Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text(
                          FOODGROUPNAMES[index][1],
                          textAlign: TextAlign.center,
                        ),
                      )),
                    ),
                  ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, 2),
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
            ),
          ),
        )
      ],
    );
  }
}
