import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/structures/fooditem.dart';

/// UI incomplete, details attempts to show nutrition details of some FoodItem
/// as a Dialog
class Details extends StatelessWidget {
  Details({this.foodItem});

  FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(foodItem.detailItems['description']['value'])),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: foodItem.buildListView(),
      ),
    );
  }
}
