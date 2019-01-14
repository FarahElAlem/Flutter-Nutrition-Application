import 'package:flutter/material.dart';

/// TODO Change database to support  decimal pt precision
/// TODO Also fill NULL values in with 0.0
/// TODO Come back to formatting
/// TODO Fill [Vitamin D, Vitamin B6] nulls
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
      'value': value['Carbohydrt_(g)'].toString(),
      'measurement': 'g',
      'name': 'Carbohydrates: '
    };
    nutritionItems['Calcium'] = {
      'value': value['Calcium_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Calcium: '
    };
    nutritionItems['Cholesterol'] = {
      'value': value['Cholestrl_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Cholesterol: '
    };
    nutritionItems['Energy'] = {
      'value': value['Energ_Kcal'].toString(),
      'measurement': 'kcal',
      'name': 'Energy: '
    };
    nutritionItems['FAMono'] = {
      'value': value['FA_Mono_(g)'].toString(),
      'measurement': 'g',
      'name': 'Monounsaturated Fat: '
    };
    nutritionItems['FAPoly'] = {
      'value': value['FA_Poly_(g)'].toString(),
      'measurement': 'g',
      'name': 'Polyunsaturated Fat: '
    };
    nutritionItems['FASat'] = {
      'value': value['FA_Sat_(g)'].toString(),
      'measurement': 'g',
      'name': 'Saturated Fat: '
    };
    detailItems['FoodGroup'] = {
      'value': value['Fd_Grp'].toString(),
      'measurement': 'N/A',
      'name': 'Food Group: '
    };
    nutritionItems['Fiber'] = {
      'value': value['Fiber_TD_(g)'].toString(),
      'measurement': 'g',
      'name': 'Total Fiber: '
    };
    nutritionItems['Iron'] = {
      'value': value['Iron_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Iron: '
    };
    nutritionItems['LipidTotal'] = {
      'value': value['Lipid_Tot_(g)'].toString(),
      'measurement': 'g',
      'name': 'Total Lipids: '
    };
    nutritionItems['Magnesium'] = {
      'value': value['Magnesium_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Magnesium: '
    };
    nutritionItems['Niacin'] = {
      'value': value['Niacin_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Niacin: '
    };
    nutritionItems['Copper'] = {
      'value': value['Copper_mg)'].toString(),
      'measurement': 'mg',
      'name': 'Copper: '
    };
    nutritionItems['Phosphorus'] = {
      'value': value['Phosphorus_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Phosphorus: '
    };
    nutritionItems['Potassium'] = {
      'value': value['Potassium_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Potassium: '
    };
    nutritionItems['Protein'] = {
      'value': value['Protein_(g)'].toString(),
      'measurement': 'g',
      'name': 'Protein: '
    };
    nutritionItems['Riboflavin'] = {
      'value': value['Riboflavin_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Riboflavin: '
    };
    detailItems['ShortDescription'] = {
      'value': value['Shrt_Desc'].toString(),
      'name': 'Short Description: '
    };
    nutritionItems['Sodium'] = {
      'value': value['Sodium_(mg)'].toString(),
      'measurement': 'g',
      'name': 'Sodium: '
    };
    nutritionItems['SugarTotal'] = {
      'value': value['Sugar_Tot_(g)'].toString(),
      'measurement': 'g',
      'name': 'Total Sugar: '
    };
    nutritionItems['Thiamin'] = {
      'value': value['Thiamin_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Thiamin: '
    };
    nutritionItems['VitaminA'] = {
      'value': value['Vit_A_RAE(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Vitamin A: '
    };
    nutritionItems['VitaminC'] = {
      'value': value['Vit_C_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Vitamin C: '
    };
    nutritionItems['VitaminB1'] = {
      'value': value['Vit_B1_(µg)'].toString(),
      'measurement': 'µg',
      'name': 'Vitamin B1: '
    };
    nutritionItems['VitaminB6'] = {
      'value': value['Vit_B6_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Vitamin B6: '
    };
    nutritionItems['VitaminD'] = {
      'value': value['Vit_D_µg'].toString(),
      'measurement': 'µg',
      'name': 'Vitamin D: '
    };
    nutritionItems['VitaminK'] = {
      'value': value['Vit_K_(µg)'].toString(),
      'measurement': 'µg',
      'name': 'Vitamin K: '
    };
    nutritionItems['VitaminE'] = {
      'value': value['Vit_E_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Vitamin E: '
    };
    nutritionItems['Water'] = {
      'value': value['Water_(g)'].toString(),
      'measurement': 'g',
      'name': 'Water: '
    };
    nutritionItems['Zinc'] = {
      'value': value['Zinc_(mg)'].toString(),
      'measurement': 'mg',
      'name': 'Zinc: '
    };
  }

  Widget buildListView() {
    return Column(
      children: [
        new Center(
          child: Text(
            'Nutrition Information\nServing Size 100g',
            textAlign: TextAlign.center,
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              'Nutrition Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            new Text('Amount')
          ],
        ),
        new Divider(),
        new Flexible(
            child: new ListView(itemExtent: 24.0, children: _buildBody()))
      ],
    );
  }

  List<Widget> _buildStructedList() {
    List<Widget> structuredList = [
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(nutritionItems['LipidTotal']['name']),
          new Text(nutritionItems['LipidTotal']['value'] +
              nutritionItems['LipidTotal']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(''),
          new Text(nutritionItems['FASat']['name']),
          new Text(nutritionItems['FASat']['value'] +
              nutritionItems['FASat']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(''),
          new Text('Trans Fat: '),
          new Text((double.parse(
                          nutritionItems['LipidTotal']['value'].toString()) -
                      (double.parse(
                              nutritionItems['FAMono']['value'].toString()) +
                          double.parse(
                              nutritionItems['FAPoly']['value'].toString()) +
                          double.parse(
                              nutritionItems['FASat']['value'].toString())))
                  .toStringAsFixed(2) +
              'g')
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(nutritionItems['Cholesterol']['name']),
          new Text(nutritionItems['Cholesterol']['value'] +
              nutritionItems['Cholesterol']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(nutritionItems['Sodium']['name']),
          new Text(nutritionItems['Sodium']['value'] +
              nutritionItems['Sodium']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(nutritionItems['Carbohydrate']['name']),
          new Text(nutritionItems['Carbohydrate']['value'] +
              nutritionItems['Carbohydrate']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(''),
          new Text(nutritionItems['Fiber']['name']),
          new Text(nutritionItems['Fiber']['value'] +
              nutritionItems['Fiber']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(''),
          new Text(nutritionItems['SugarTotal']['name']),
          new Text(nutritionItems['SugarTotal']['value'] +
              nutritionItems['SugarTotal']['measurement'])
        ],
      ),
      new Divider(
        color: Colors.grey,
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(nutritionItems['VitaminD']['name']),
          new Text(nutritionItems['VitaminD']['value'] +
              nutritionItems['VitaminD']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(nutritionItems['Calcium']['name']),
          new Text(nutritionItems['Calcium']['value'] +
              nutritionItems['Calcium']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(nutritionItems['Iron']['name']),
          new Text(nutritionItems['Iron']['value'] +
              nutritionItems['Iron']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(nutritionItems['Potassium']['name']),
          new Text(nutritionItems['Potassium']['value'] +
              nutritionItems['Potassium']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(nutritionItems['VitaminC']['name']),
          new Text(nutritionItems['VitaminC']['value'] +
              nutritionItems['VitaminC']['measurement'])
        ],
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(nutritionItems['VitaminB6']['name']),
          new Text(nutritionItems['VitaminB6']['value'] +
              nutritionItems['VitaminB6']['measurement'])
        ],
      ),
    ];

    return structuredList;
  }

  List<Widget> _buildRemainderList() {
    List<Widget> remainderWidgets = [];
    nutritionItems.forEach((key, value) {
      if (!_exceptionKeys.contains(key.toString())) {
        remainderWidgets.add(new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(value['name']),
            new Text(value['value'] + value['measurement'])
          ],
        ));
      }
    });

    return remainderWidgets;
  }

  List<Widget> _buildBody() {
    List<Widget> list1 = _buildStructedList();
    List<Widget> list2 = _buildRemainderList();

    return new List.from(list1)..addAll(list2);
  }

  @override
  String toString() {
    return 'FoodItem{nutritionItems: $nutritionItems, detailItems: $detailItems}';
  }
}
