import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/structures/fooditem.dart';

/// UI incomplete, details attempts to show nutrition details of some FoodItem
/// as a Dialog
class Details extends StatelessWidget {
  Details({this.foodItem});

  FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(4.0),
        child: new Column(
          children: <Widget>[new Flexible(child: foodItem.buildListView())],
        ),
      ),
    );
  }
}