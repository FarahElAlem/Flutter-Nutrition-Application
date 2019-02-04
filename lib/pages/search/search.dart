import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nutrition_app_flutter/pages/search/details.dart';
import 'package:nutrition_app_flutter/pages/search/itemwidget.dart';

/// class Search represents a Stateful widget that can have multiple states:
/// - Seeking / Searching:
///     - Consists of a StaggeredGridView of elements gathered from Firebase.
/// - Result Gathering
///     - Result of a query gathered from Firebase that users can interact with.
class Search extends StatefulWidget {
  Search({this.foodGroupNames, this.foodGroupUrls});

  List<List<String>> foodGroupNames;
  Map<String, String> foodGroupUrls;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _built = false;

  TextEditingController _searchController;

  @override
  void initState() {
    _searchController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Future<void> executeAfterBuild() async {
    _built = true;
  }

  /// TODO make db images 256px or 128px
  @override
  Widget build(BuildContext context) {
    executeAfterBuild();
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 8.0),
            child: TextField(
//              style: Theme.of(context).textTheme.,
              controller: _searchController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ))),
              onSubmitted: (String text) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchDetails(query: text)));
              },
            ),
          ),
        ),
        new Expanded(
          child: new Container(
            padding: new EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 4.0),
            child: new StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: widget.foodGroupNames.length,
              itemBuilder: ((BuildContext context, int index) {
                return ItemWidget(
                  foodGroupNames: widget.foodGroupNames,
                  foodGroupUrls: widget.foodGroupUrls,
                  index: index,
                );
              }),
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
