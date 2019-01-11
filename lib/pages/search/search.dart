import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          padding: EdgeInsets.all(14.0),
          child: Text(
            'Search By Food Group',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        new Expanded(
          child: new Container(
            padding: new EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 4.0),
            child: new StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: 24,
              itemBuilder: (BuildContext context, int index) => new Card(
                    color: Color.fromRGBO(33, 150, 243, .5),
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
