import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  Result({this.foodGroup});

  String foodGroup;

  @override
  _ResultState createState() => _ResultState(foodGroup: foodGroup);
}

class _ResultState extends State<Result> {
  _ResultState({this.foodGroup});

  String foodGroup;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Center(
        child: Text(foodGroup),
      ),
    );
  }
}
