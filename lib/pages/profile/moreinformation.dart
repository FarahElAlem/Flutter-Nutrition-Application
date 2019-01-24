import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search/result.dart';
import 'package:nutrition_app_flutter/globals.dart';

/// This is a new page navigated to by profile.
/// This creates a listview of user saved data for extended inspection
/// TODO Add some limit on the amount of user items this can edit
class ProfileInfo extends StatelessWidget {
  ProfileInfo({this.type});

  int type;

  List<Widget> children;

  Widget _buildBody() {
    if (type == 0) {
      return new ListView.builder(
          itemCount: SAVEDNUTRIENTS.length,
          itemBuilder: (BuildContext context, int index) {
            return new ListItem(
              foodItem: SAVEDNUTRIENTS[index],
            );
          });
    } else if (type == 1) {}
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: (type == 0)
            ? new Text('My Nutrient List')
            : new Text('My Recipe List'),
      ),
      body: new Center(
        child: _buildBody(),
      ),
    );
  }
}
