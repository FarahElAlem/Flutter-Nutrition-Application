/// TODO https://www.youtube.com/watch?v=FPcl1tu0gDs

import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/recipe/details.dart';
import 'package:nutrition_app_flutter/pages/search/details.dart';
import 'package:nutrition_app_flutter/storage/usercache.dart';

class MaterialSearch extends SearchDelegate<String> {
  MaterialSearch({this.items, this.type, this.userCache});

  final UserCache userCache;
  final List<dynamic> items;
  final String type;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white),
        primaryColor: Colors.white,
        textTheme: Theme.of(context).accentTextTheme);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = items
        .where((p) => p['title']
            .toLowerCase()
            .trim()
            .contains(new RegExp(r'' + query.toLowerCase().trim() + '')))
        .toList();
    
    return (suggestionList.length > 0)
        ? Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: suggestionList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: RichText(
                        text: TextSpan(
                      text: suggestionList[index]['title'],
                      style: Theme.of(context).accentTextTheme.title,
                    )),
                    subtitle: RichText(
                      text: TextSpan(
                          text: suggestionList[index]['subtitle'],
                          style: Theme.of(context).accentTextTheme.subtitle),
                    ),
                    onTap: () {
                      if (type == 'create') {
                        close(context, suggestionList[index]['title']);
                      } else if (type == 'browse-recipe') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipeDetails(
                                      recipeItem: suggestionList[index]
                                          ['title'],
                                      type: 'search',
                                  userCache: userCache,
                                    )));
                      } else if (type == 'browse-nutrient') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NutrientDetails(
                                    itemKey: suggestionList[index]['title'],
                                  userCache: userCache,)));
                      }
                    },
                  );
                }),
          )
        : Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'No Results Found!',
                style: Theme.of(context).accentTextTheme.title,
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
