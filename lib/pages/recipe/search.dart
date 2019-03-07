import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:NutriAssistant/pages/recipe/utilities/recipelisttile.dart';
import 'package:NutriAssistant/pages/utility/splash.dart';

class ResultsSearchPage extends StatefulWidget {
  _ResultsSearchPageState createState() => new _ResultsSearchPageState();
}

class _ResultsSearchPageState extends State<ResultsSearchPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this, length: 3);
    _searchController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: new StreamBuilder(
                stream: Firestore.instance
                    .collection('RECIPES')
                    .orderBy('name')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SplashScreenAuth();
                  } else {

                    return new ListView.builder(
                        itemExtent: 130.0,
                        padding: EdgeInsets.all(8.0),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.documents[index];
                          return RecipeListTile(ds: ds);
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
