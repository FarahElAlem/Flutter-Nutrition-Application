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
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Container(
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
