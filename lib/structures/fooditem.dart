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
      'value': value['Vit_A_RAE'].toString(),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildBody(),
    );
  }

  List<Widget> _buildGeneralInformation() {
    return [
      getHeadingText('General Information'),
      Divider(
        color: Colors.black,
        height: 36.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          getSubHeadingText('Serving Size:'),
          getMainContentText('100g'),
        ],
      ),
    ];
  }

//  getSubHeadingText(
//  this.nutritionItems['Carbohydrate']['name']),
//  getMainContentText(this.nutritionItems['Carbohydrate']
//  ['value'] +
//  this.nutritionItems['Carbohydrate']['measurement']),
//  getMainContentText('2%')

  List<Widget> _buildNutritionInformation() {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getHeadingText('Nutrition Information'),
        ],
      ),
      Divider(
        color: Colors.black,
        height: 36.0,
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child:
                getSubHeadingText(this.nutritionItems['Carbohydrate']['name']),
          ),
          Expanded(
            flex: 3,
            child: getMainContentText(this.nutritionItems['Carbohydrate']
                    ['value'] +
                this.nutritionItems['Carbohydrate']['measurement']),
          ),
          Expanded(
            flex: 1,
            child: getMainContentText('2%'),
          )
        ],
      ),
      Divider(),
      Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child:
            getSubHeadingText(this.nutritionItems['Fiber']['name']),
          ),
          Expanded(
            flex: 3,
            child: getMainContentText(this.nutritionItems['Fiber']
            ['value'] +
                this.nutritionItems['Fiber']['measurement']),
          ),
          Expanded(
            flex: 1,
            child: getMainContentText('6%'),
          )
        ],
      ),
    ];
  }

  List<Widget> _buildBody() {
    List<Widget> _body = [];
    _body.addAll(_buildGeneralInformation());
    _body.add(Divider(height: 48.0));
    _body.addAll(_buildNutritionInformation());

    return _body;
  }

  @override
  String toString() {
    return 'FoodItem{nutritionItems: $nutritionItems, detailItems: $detailItems}';
  }
}
