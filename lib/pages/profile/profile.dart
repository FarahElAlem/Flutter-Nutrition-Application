import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/globals.dart';
import 'package:nutrition_app_flutter/pages/profile/moreinformation.dart';
import 'package:nutrition_app_flutter/pages/search/result.dart';

class Profile extends StatelessWidget {
  Widget _getFavoriteNutrients(BuildContext context) {
    return new Container(
        constraints: BoxConstraints(
            maxHeight: (60.0 *
                ((SAVEDNUTRIENTS.length < 3) ? SAVEDNUTRIENTS.length : 3)),
            maxWidth: double.maxFinite),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            itemCount:
                ((SAVEDNUTRIENTS.length < 3) ? SAVEDNUTRIENTS.length : 3),
            itemBuilder: (context, i) {
              return new ListItem(
                foodItem: SAVEDNUTRIENTS[i],
                type: 1,
              );
            }));
  }

  Widget _getFavoriteRecipes(BuildContext context) {
    return new Container(
        constraints: BoxConstraints(
            maxHeight:
                (60.0 * ((SAVEDRECIPES.length < 3) ? SAVEDRECIPES.length : 3)),
            maxWidth: double.maxFinite),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            itemCount: ((SAVEDRECIPES.length < 3) ? SAVEDRECIPES.length : 3),
            itemBuilder: (context, i) {
              return new ListTile(
                title: new Text(SAVEDRECIPES[i]['title']),
                trailing: new Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              );
            }));
  }

  Widget _showMoreNutrientButton(BuildContext context) {
    return new Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new MaterialButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileInfo(type: 0,)));
          },
          child: new Text('More...'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: new Icon(
                  Icons.account_circle,
                  size: 160.0,
                ),
              )
            ],
          ),
          new Padding(
            padding: EdgeInsets.all(24.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('Name:\n' + 'John Doe'),
                new Text('Age:\n' + '27')
              ],
            ),
          ),
          new Padding(
            padding: EdgeInsets.all(24.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('Favorite Recipe:\n' + 'Green Eggs and Ham'),
                new Text('Most Recent Serach:\n' + 'Chocolate covered nuts')
              ],
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(
            padding: new EdgeInsets.all(8.0),
            child: new Text(
              'Favorite Nutrients:',
              textAlign: TextAlign.start,
            ),
          ),
          _getFavoriteNutrients(context),
          (SAVEDNUTRIENTS.length > 3)
              ? _showMoreNutrientButton(context)
              : new Container(
                  width: 0,
                  height: 0,
                ),
          new Divider(
            height: 1.0,
          ),
          new Container(
            padding: new EdgeInsets.all(8.0),
            child: new Text(
              'Favorite Recipes:',
              textAlign: TextAlign.start,
            ),
          ),
          _getFavoriteRecipes(context)
        ],
      ),
    );
  }
}
