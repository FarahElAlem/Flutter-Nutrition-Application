import 'package:flutter/material.dart';

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

  Widget buildListView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBody(context),
      ),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
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
    out.add(Text(
      'General Information',
      style: Theme.of(context).textTheme.headline,
    ));
    out.add(Divider(
      color: Colors.black,
    ));
    out.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          this.nutritionItems['calorie']['name'],
          style: Theme.of(context).textTheme.body1,
        ),
        Text(
          this.nutritionItems['calorie']['value'] +
              this.nutritionItems['calorie']['measurement'],
          style: Theme.of(context).textTheme.body1,
        )
      ],
    ));
    out.add(Divider(
      height: 8.0,
      color: Colors.transparent,
    ));
    out.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Serving Size:',
          style: Theme.of(context).textTheme.body1,
        ),
        Text(
          '100g',
          style: Theme.of(context).textTheme.body1,
        )
      ],
    ));
    out.add(Divider(
      height: 48.0,
      color: Colors.transparent,
    ));

    /// Nutrition Information Adding to Body
    out.add(Text(
      'Nutrition Information',
      style: Theme.of(context).textTheme.headline,
    ));
    out.add(Padding(
        padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(
                'Name',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Amount',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Expanded(
              child: Text(
                'Daily %',
                style: Theme.of(context).textTheme.body2,
              ),
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
            child: Text(this.nutritionItems[key]['name']),
          ),
          Expanded(
            flex: 2,
            child: Text(this.nutritionItems[key]['value'] +
                this.nutritionItems[key]['measurement']),
          ),
          Expanded(
            child: Text(this.nutritionItems[key]['daily']),
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
                child: Text(
                  '\t\t' + this.nutritionItems[key]['name'],
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                    this.nutritionItems[key]['value'] +
                        this.nutritionItems[key]['measurement'],
                    style: Theme.of(context).textTheme.body1),
              ),
              Expanded(
                child: Text(this.nutritionItems[key]['daily'],
                    style: Theme.of(context).textTheme.body1),
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
