import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nutrition_app_flutter/pages/search/details.dart';
import 'package:nutrition_app_flutter/pages/search/foodgroupcard.dart';

/// class Search represents a Stateful widget that can have multiple states:
/// - Seeking / Searching:
///     - Consists of a StaggeredGridView of elements gathered from Firebase.
/// - Result Gathering
///     - Result of a query gathered from Firebase that users can interact with.
class Search extends StatefulWidget {
  Search({this.foodGroupDetails});

  Map<String, dynamic> foodGroupDetails;

  @override
  _SearchState createState() =>
      _SearchState(foodGroupDetails: foodGroupDetails);
}

class _SearchState extends State<Search> {
  _SearchState({this.foodGroupDetails});

  Map<String, dynamic> foodGroupDetails;

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

  /// TODO make db images 256px or 128px
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.only(top: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 8.0),
              child: TextField(
                controller: _searchController,
                style: Theme.of(context).textTheme.body1,
                decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.caption,
                    contentPadding: EdgeInsets.all(0.0),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.grey,),
                    focusedBorder: new OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(40.0),
                        )),
                    enabledBorder: new OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(40.0),
                        )),
                    border: new OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(40.0),
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
                itemCount: widget.foodGroupDetails.keys.length,
                itemBuilder: ((BuildContext context, int index) {
                  return FoodGroupCard(
                    foodItemInformation:
                        foodGroupDetails[foodGroupDetails.keys.toList()[index]],
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
      ),
    );
  }
}
