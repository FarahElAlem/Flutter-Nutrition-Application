import 'package:NutriAssistant/pages/search/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// TODO https://www.youtube.com/watch?v=FPcl1tu0gDs

import 'package:flutter/material.dart';
import 'package:NutriAssistant/pages/recipe/details.dart';

/// TODO https://www.youtube.com/watch?v=FPcl1tu0gDs

class MaterialSearch extends SearchDelegate<String> {
  MaterialSearch({this.items, this.type});

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
                    onTap: () async {
                      if (type == 'create') {
                        close(context, suggestionList[index]['title']);
                      } else if (type == 'browse-recipe') {
                        print('called browse-recipe');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipeDetails(
                                      recipeItem: suggestionList[index]
                                          ['title'],
                                      type: 'search',
                                    )));
                      } else if (type == 'browse-nutrient') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NutrientDetails(
                                      itemKey: suggestionList[index]['title'],
                                    )));
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
