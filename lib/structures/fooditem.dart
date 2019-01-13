import 'package:flutter/material.dart';

class FoodItem {
  Map nutritionItems = new Map();
  Map detailItems = new Map();

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
      'name': 'Monounsaturated Fatty Acids: '
    };
    nutritionItems['FAPoly'] = {
      'value': value['FA_Poly_(g)'].toString(),
      'measurement': 'g',
      'name': 'Polyunsaturated Fatty Acids: '
    };
    nutritionItems['FASat'] = {
      'value': value['FA_Sat_(g)'].toString(),
      'measurement': 'g',
      'name': 'Saturated Fatty Acid: '
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
    nutritionItems['VitaminB12'] = {
      'value': value['Vit_B12_(µg)'].toString(),
      'measurement': 'µg',
      'name': 'Vitamin B12: '
    };
    nutritionItems['VitaminB6'] = {
      'value': value['Vit_B6_(µg)'].toString(),
      'measurement': 'µg',
      'name': 'Vitamin B6: '
    };
    nutritionItems['VitaminD'] = {
      'value': value['Vit_D_(µg)'].toString(),
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
      children: <Widget>[
        new Center(
          child: Text(
            'Nutrition Information\nServing Size 100g',
            textAlign: TextAlign.center,
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text('Nutrition Name', style: TextStyle(fontWeight: FontWeight.bold),),
            new Text('Amount')
          ],
        ),
        new Divider(),
        new Flexible(
            child: ListView.builder(
                itemCount: nutritionItems.keys.length,
                itemExtent: 30.0,
                itemBuilder: (BuildContext context, int index) {
                  return _buildListItem(index);
                }))
      ],
    );
  }

  Widget _buildListItem(int index) {
    String key = nutritionItems.keys.toList()[index];
    var item = nutritionItems[key];

    return new Column(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(item['name'], style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold)),
            new Text((item['value'] == 'null' ? '0.0' : item['value']) + " " + item['measurement'])
          ],
        )
      ],
    );
  }

  @override
  String toString() {
    return 'FoodItem{nutritionItems: $nutritionItems, detailItems: $detailItems}';
  }
}
