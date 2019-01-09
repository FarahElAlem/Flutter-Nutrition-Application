import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> _tabs = <Tab>[
    new Tab(
      icon: new Icon(Icons.fastfood),
      text: 'Search Food',
    ),
    new Tab(
      icon: new Icon(Icons.receipt),
      text: 'Search Recipies',
    )
  ];

  final List<Widget> _children = <Widget>[
    new _SearchFood(),
    new _SearchRecipe()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new TabBar(
          controller: _tabController, tabs: _tabs, labelColor: Colors.blue),
      body: new TabBarView(controller: _tabController, children: _children),
    );
  }
}

class _SearchFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            padding: const EdgeInsets.all(20.0),
            child: new TextField(
                onSubmitted: null,
                decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search),
                  hintText: 'Search for Food',
                ))));
  }
}

class _SearchRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            padding: const EdgeInsets.all(20.0),
            child: new TextField(
                onSubmitted: null,
                decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search),
                  hintText: 'Search for Recipies',
                ))));
  }
}
