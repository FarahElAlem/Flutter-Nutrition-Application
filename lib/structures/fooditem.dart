import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/globals.dart';

/// FoodItem class that stores information gathered from the
/// Cloud Firestore Database. Contains a build function that formats
/// the nutrition data on request.
class FoodItem {
  Map nutritionItems = new Map();
  Map detailItems = new Map();

  FoodItem(var value) {
    nutritionItems['carbohydrate'] = {
      'value': value['carbohydrate'].toString().trim(),
      'measurement': 'g',
      'name': 'Carbohydrates:',
      'daily':
          (double.parse(value['carbohydrate']) / 325.0).toStringAsFixed(1) + '%'
    };
    nutritionItems['calcium'] = {
      'value': value['calcium'].toString().trim(),
      'measurement': 'mg',
      'name': 'Calcium:',
      'daily':
          (double.parse(value['calcium']) * 100 / 1000.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['cholesterol'] = {
      'value': value['cholesterol)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Cholesterol:',
      'daily': (double.parse(value['cholesterol']) * 100 / 300.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['calorie'] = {
      'value': value['calorie'].toString().trim(),
      'measurement': 'cal',
      'name': 'Calories:',
      'daily':
          (double.parse(value['calorie']) / 2079.0).toStringAsFixed(1) + '%'
    };
    detailItems['foodgroup'] = {
      'value': value['foodgroup'].toString().trim(),
      'measurement': 'N/A',
      'name': 'Food Group: '
    };
    nutritionItems['fiber'] = {
      'value': value['fiber'].toString().trim(),
      'measurement': 'g',
      'name': 'Total Fiber:',
      'daily':
          (double.parse(value['fiber']) * 100 / 30.0).toStringAsFixed(1) + '%'
    };
    nutritionItems['iron'] = {
      'value': value['iron'].toString().trim(),
      'measurement': 'mg',
      'name': 'Iron:',
      'daily':
          (double.parse(value['iron']) * 100 / 15.1).toStringAsFixed(1) + '%'
    };
    nutritionItems['lipid'] = {
      'value': value['lipid'].toString().trim(),
      'measurement': 'g',
      'name': 'Total Fat:',
      'daily':
          (double.parse(value['lipid']) * 100 / 77.0).toStringAsFixed(1) + '%'
    };
    nutritionItems['potassium'] = {
      'value': value['potassium'].toString().trim(),
      'measurement': 'mg',
      'name': 'Potassium:',
      'daily':
          (double.parse(value['potassium']) * 100 / 4700.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['protein'] = {
      'value': value['protein'].toString().trim(),
      'measurement': 'g',
      'name': 'Protein:',
      'daily':
          (double.parse(value['protein']) * 100 / 56.0).toStringAsFixed(1) + '%'
    };
    detailItems['description'] = {
      'value': value['description'].toString().trim(),
      'name': 'Description: '
    };
    nutritionItems['sodium'] = {
      'value': value['sodium'].toString().trim(),
      'measurement': 'mg',
      'name': 'Sodium:',
      'daily':
          (double.parse(value['sodium']) * 100 / 2300.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['sugar'] = {
      'value': value['sugar'].toString().trim(),
      'measurement': 'g',
      'name': 'Total Sugar:',
      'daily':
          (double.parse(value['sugar']) * 100 / 31.0).toStringAsFixed(1) + '%'
    };
    nutritionItems['vitamind'] = {
      'value': value['vitamind'].toString().trim(),
      'measurement': 'µg',
      'name': 'Vitamin D:',
      'daily':
          (double.parse(value['vitamind']) * 100 / 20.0).toStringAsFixed(1) +
              '%'
    };
  }

  Widget buildListView() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    Map<String, List<String>> names = {
      'lipid': [],
      'cholesterol': [],
      'sodium': [],
      'carbohydrate': ['fiber', 'sugar'],
      'protein': [],
      'calcium': [],
      'iron': [],
      'potassium': []
    };

    var tKeys = [
      'lipid',
      'cholesterol',
      'sodium',
      'carbohydrate',
      'protein',
      'calcium',
      'iron',
      'potassium',
      'fiber',
      'sugar'
    ];

    List<Widget> out = [];

    /// General Information Adding to Body
    out.add(getHeadingText('General Information'));
    out.add(Divider(
      color: Colors.black,
    ));
    out.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getMainContentText(this.nutritionItems['calorie']['name']),
        getMainContentText(this.nutritionItems['calorie']['value'] +
            this.nutritionItems['calorie']['measurement'])
      ],
    ));
    out.add(Divider(
      height: 8.0,
      color: Colors.transparent,
    ));
    out.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getMainContentText('Serving Size:'),
        getMainContentText('100g'),
      ],
    ));
    out.add(Divider(
      height: 48.0,
      color: Colors.transparent,
    ));

    /// Nutrition Information Adding to Body
    out.add(getHeadingText('Nutrition Information'));
    out.add(Padding(
        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: getDetailsBoldText('Name'),
            ),
            Expanded(
              flex: 2,
              child: getDetailsBoldText('Amount'),
            ),
            Expanded(
              child: getDetailsBoldText('Daily %'),
            )
          ],
        )));
    out.add(Divider(
      color: Colors.black,
      height: 0,
    ));
    out.add(Divider(
      height: 8.0,
      color: Colors.transparent,
    ));
    for (String key in names.keys) {
      out.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: getMainContentText(this.nutritionItems[key]['name']),
          ),
          Expanded(
            flex: 2,
            child: getMainContentText(this.nutritionItems[key]['value'] +
                this.nutritionItems[key]['measurement']),
          ),
          Expanded(
            child: getMainContentText(this.nutritionItems[key]['daily']),
          )
        ],
      ));
      out.add(Divider(
        color: Colors.transparent,
      ));
      if (names[key].length > 0) {
        for (String key in names[key]) {
          out.add(Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: getMainContentText(
                    '\t\t' + this.nutritionItems[key]['name']),
              ),
              Expanded(
                flex: 2,
                child: getMainContentText(this.nutritionItems[key]['value'] +
                    this.nutritionItems[key]['measurement']),
              ),
              Expanded(
                child: getMainContentText(this.nutritionItems[key]['daily']),
              )
            ],
          ));
          out.add(Divider(
            color: Colors.transparent,
          ));
        }
      }
    }
    out.removeLast();

    return out;
  }

  @override
  String toString() {
    return 'FoodItem{nutritionItems: $nutritionItems, detailItems: $detailItems}';
  }
}
