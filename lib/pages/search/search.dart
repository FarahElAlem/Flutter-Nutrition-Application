import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'foodgroupresult.dart';

/// class Search represents a Stateful widget that can have multiple states:
/// - Seeking / Searching:
///     - Consists of a StaggeredGridView of elements gathered from Firebase.
/// - Result Gathering
///     - Result of a query gathered from Firebase that users can interact with.
class Search extends StatefulWidget {
  Search({this.foodGroupNames, this.foodGroupImages});

  List<List<String>> foodGroupNames;
  Map<String, Image> foodGroupImages;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
  }

  /// TODO make db images 256px or 128px
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
              crossAxisCount: 2,
              itemCount: widget.foodGroupNames.length,
              itemBuilder: (BuildContext context, int index) =>
              new InkWell(
                onTap: () {
                  /// onTap(): creates a results page full of different nutrient items from the food group selected
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FoodGroupResult(
                                foodInformation: widget.foodGroupNames[index],
                                type: 0,
                                foodImage: widget.foodGroupImages[widget.foodGroupNames[index][1]],
                              )));
                },
                splashColor: Colors.transparent,
                child: new Card(
                  elevation: 5.0,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          child: Hero(tag: widget.foodGroupNames[index][0],
                              child: new Container(
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      alignment: FractionalOffset.topCenter,
                                      image: widget.foodGroupImages[widget.foodGroupNames[index][1]].image,
                                    )),
                              )),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: SizedBox.expand(
                            child: Material(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        12.0, 0.0, 12.0, 0.0),
                                    child: getIconText(
                                        widget.foodGroupNames[index][1],
                                        textAlign: TextAlign.center, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
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
