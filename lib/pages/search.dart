import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search({this.tabs, this.searchTabController});

  List<Widget> tabs;
  TabController searchTabController;

  @override
  _SearchState createState() => _SearchState(searchTabController: searchTabController, tabs: tabs);
}

class _SearchState extends State<Search> {

  _SearchState({this.tabs, this.searchTabController});

  List<Widget> tabs;
  TabController searchTabController;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: new TabBarView(controller: searchTabController, children: tabs),
    );
  }
}

class SearchFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            padding: const EdgeInsets.all(20.0),
            child: new TextField(
                onSubmitted: null,
                decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search),
                  hintText: 'Search for Nutrition',
                ))));
  }
}

class SearchRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            padding: const EdgeInsets.all(20.0),
            child: new TextField(
                onSubmitted: null,
                decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search),
                  hintText: 'Search for Recipes',
                ))));
  }
}
