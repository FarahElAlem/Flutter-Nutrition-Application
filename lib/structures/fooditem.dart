import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/globals.dart';

/// TODO Change database to support  decimal pt precision
/// TODO Also fill NULL values in with 0.0
/// TODO Come back to formatting
/// TODO Fill [Vitamin D, Vitamin B6]
class FoodItem {
  Map nutritionItems = new Map();
  Map detailItems = new Map();

  List<String> _exceptionKeys = [
    'LipidTotal',
    'FASat',
    'Cholesterol',
    'Sodium',
    'Carbohydrate',
    'Fiber',
    'SugarTotal',
    'Protein',
    'VitaminD',
    'Calcium',
    'Iron',
    'Potassium',
    'VitaminC',
    'VitaminB6',
  ];

  FoodItem(var value) {
    nutritionItems['Carbohydrate'] = {
      'value': value['Carbohydrt_(g)'].toString().trim(),
      'measurement': 'g',
      'name': 'Carbohydrates:',
      'daily':
          (double.parse(value['Carbohydrt_(g)']) / 325.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['Calcium'] = {
      'value': value['Calcium_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Calcium:',
      'daily': (double.parse(value['Calcium_(mg)']) * 100 / 1000.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['Cholesterol'] = {
      'value': value['Cholestrl_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Cholesterol:',
      'daily': (double.parse(value['Calcium_(mg)']) * 100 / 300.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['Energy'] = {
      'value': value['Energ_Kcal'].toString().trim(),
      'measurement': 'kcal',
      'name': 'Energy:',
      'daily': (double.parse(value['Energ_Kcal']) * 100 / 2079.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['FAMono'] = {
      'value': value['FA_Mono_(g)'].toString().trim(),
      'measurement': 'g',
      'name': 'Mono Fat:',
      'daily':
          (double.parse(value['FA_Mono_(g)']) * 100 / 77.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['FAPoly'] = {
      'value': value['FA_Poly_(g)'].toString().trim(),
      'measurement': 'g',
      'name': 'Poly Fat:',
      'daily':
          (double.parse(value['FA_Poly_(g)']) * 100 / 77.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['FASat'] = {
      'value': value['FA_Sat_(g)'].toString().trim(),
      'measurement': 'g',
      'name': 'Saturated Fat:',
      'daily':
          (double.parse(value['FA_Sat_(g)']) * 100 / 77.0).toStringAsFixed(1) +
              '%'
    };
    detailItems['FoodGroup'] = {
      'value': value['Fd_Grp'].toString().trim(),
      'measurement': 'N/A',
      'name': 'Food Group: '
    };
    nutritionItems['Fiber'] = {
      'value': value['Fiber_TD_(g)'].toString().trim(),
      'measurement': 'g',
      'name': 'Total Fiber:',
      'daily':
          (double.parse(value['FA_Sat_(g)']) * 100 / 30.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['Iron'] = {
      'value': value['Iron_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Iron:',
      'daily':
          (double.parse(value['Iron_(mg)']) * 100 / 15.1).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['LipidTotal'] = {
      'value': value['Lipid_Tot_(g)'].toString().trim(),
      'measurement': 'g',
      'name': 'Total Lipids:',
      'daily': (double.parse(value['Lipid_Tot_(g)']) * 100 / 77.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['Magnesium'] = {
      'value': value['Magnesium_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Magnesium:',
      'daily': (double.parse(value['Magnesium_(mg)']) * 100 / 420.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['Niacin'] = {
      'value': value['Niacin_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Niacin:',
      'daily':
          (double.parse(value['Niacin_(mg)']) * 100 / 35.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['Copper'] = {
      'value': value['Copper_mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Copper:',
      'daily':
          (double.parse(value['Copper_mg)']) * 100 / 1.6).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['Phosphorus'] = {
      'value': value['Phosphorus_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Phosphorus:',
      'daily': (double.parse(value['Phosphorus_(mg)']) * 100 / 700.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['Potassium'] = {
      'value': value['Potassium_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Potassium:',
      'daily': (double.parse(value['Potassium_(mg)']) * 100 / 4700.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['Protein'] = {
      'value': value['Protein_(g)'].toString().trim(),
      'measurement': 'g',
      'name': 'Protein:',
      'daily':
          (double.parse(value['Protein_(g)']) * 100 / 56.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['Riboflavin'] = {
      'value': value['Riboflavin_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Riboflavin:',
      'daily': (double.parse(value['Riboflavin_(mg)']) * 100 / 1.3)
              .toStringAsFixed(1) +
          '%'
    };
    detailItems['ShortDescription'] = {
      'value': value['Shrt_Desc'].toString().trim(),
      'name': 'Short Description: '
    };
    nutritionItems['Sodium'] = {
      'value': value['Sodium_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Sodium:',
      'daily': (double.parse(value['Sodium_(mg)']) * 100 / 2300.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['SugarTotal'] = {
      'value': value['Sugar_Tot_(g)'].toString().trim(),
      'measurement': 'g',
      'name': 'Total Sugar:',
      'daily': (double.parse(value['Sugar_Tot_(g)']) * 100 / 31.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['Thiamin'] = {
      'value': value['Thiamin_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Thiamin:',
      'daily': (double.parse(value['Thiamin_(mg)']) * 100 / 4.89)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['VitaminA'] = {
      'value': value['Vit_A_RAE'].toString().trim(),
      'measurement': 'mg',
      'name': 'Vitamin A:',
      'daily':
          (double.parse(value['Vit_A_RAE']) * 100 / 800).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['VitaminC'] = {
      'value': value['Vit_C_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Vitamin C:',
      'daily':
          (double.parse(value['Vit_C_(mg)']) * 100 / 90.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['VitaminB12'] = {
      'value': value['Vit_B12_(µg)'].toString().trim(),
      'measurement': 'µg',
      'name': 'Vitamin B12:',
      'daily': (double.parse(value['Vit_B12_(µg)']) * 100 / 25.0)
              .toStringAsFixed(1) +
          '%'
    };
    nutritionItems['VitaminB6'] = {
      'value': value['Vit_B6_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Vitamin B6:',
      'daily':
          (double.parse(value['Vit_B6_(mg)']) * 100 / 1.3).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['VitaminD'] = {
      'value': value['Vit_D_µg'].toString().trim(),
      'measurement': 'µg',
      'name': 'Vitamin D:',
      'daily':
          (double.parse(value['Vit_D_µg']) * 100 / 20.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['VitaminK'] = {
      'value': value['Vit_K_(µg)'].toString().trim(),
      'measurement': 'µg',
      'name': 'Vitamin K:',
      'daily':
          (double.parse(value['Vit_K_(µg)']) * 100 / 120.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['VitaminE'] = {
      'value': value['Vit_E_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Vitamin E:',
      'daily':
          (double.parse(value['Vit_E_(mg)']) * 100 / 15.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['Water'] = {
      'value': value['Water_(g)'].toString().trim(),
      'measurement': 'g',
      'name': 'Water:',
      'daily':
          (double.parse(value['Water_(g)']) * 100 / 3200.0).toStringAsFixed(1) +
              '%'
    };
    nutritionItems['Zinc'] = {
      'value': value['Zinc_(mg)'].toString().trim(),
      'measurement': 'mg',
      'name': 'Zinc:',
      'daily':
          (double.parse(value['Zinc_(mg)']) * 100 / 15.0).toStringAsFixed(1) +
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
      'LipidTotal': ['FAMono', 'FAPoly', 'FASat'],
      'Cholesterol': [],
      'Sodium': [],
      'Carbohydrate': ['Fiber', 'SugarTotal'],
      'Protein': [],
      'Calcium': [],
      'Iron': [],
      'Potassium': []
    };

    var tKeys = [
      'LipidTotal',
      'Cholesterol',
      'Sodium',
      'Carbohydrate',
      'Protein',
      'Calcium',
      'Iron',
      'Potassium',
      'FAMono',
      'FAPoly',
      'FASat',
      'Fiber',
      'SugarTotal'
    ];
    var nKeys = this.nutritionItems.keys;
    List<String> rKeys = [];
    List<String> vKeys = [];
    for (String k in nKeys) {
      if (!tKeys.contains(k) && !k.contains('Vitamin')) {
        rKeys.add(k);
      } else if (!tKeys.contains(k) && k.contains('Vitamin')) {
        vKeys.add(k);
      }
    }

    List<Widget> out = [];

    /// General Information Adding to Body
    out.add(getHeadingText('General Information'));
    out.add(Divider(
      color: Colors.black,
    ));
    out.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getSubHeadingText('Serving Size:'),
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
            child: getSubHeadingText(this.nutritionItems[key]['name']),
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
                child: getSubHeadingText(
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
    out.add(Divider(
      height: 48.0,
      color: Colors.transparent,
    ));

    /// Vitamin Information Adding to Body
    out.add(getHeadingText('Vitamin Information'));
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
    for (String key in vKeys) {
      out.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: getSubHeadingText(this.nutritionItems[key]['name']),
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
    out.removeLast();
    out.add(Divider(
      height: 48.0,
      color: Colors.transparent,
    ));

    /// Other Information Adding to Body
    /// TODO Random inconsistent render problems
    out.add(getHeadingText('Other Information'));
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
    for (String key in rKeys) {
      out.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: getSubHeadingText(this.nutritionItems[key]['name']),
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
    out.removeLast();

    return out;
  }

  @override
  String toString() {
    return 'FoodItem{nutritionItems: $nutritionItems, detailItems: $detailItems}';
  }
}
