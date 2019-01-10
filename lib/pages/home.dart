import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/demo/placeholder.dart';
import 'package:nutrition_app_flutter/pages/dashboard.dart';
import 'package:nutrition_app_flutter/pages/search.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  Home({this.app});

  final FirebaseApp app;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Current widget index.
  int _currentIndex = 0;

  // Firebase Database instance
  static final FirebaseDatabase database = FirebaseDatabase.instance;

  List<Widget> _appBarBottom;

  // List of children that define the pages
  // that a user sees.
  List<Widget> _bodyChildren;

  @override
  void initState() {
    super.initState();

    // For Search
    TabController _searchTabController;

    final List<Tab> _tabs = <Tab>[
      new Tab(
        icon: new Icon(Icons.fastfood),
        text: 'Search Nutrition',
      ),
      new Tab(
        icon: new Icon(Icons.receipt),
        text: 'Search Recipes',
      )
    ];

    List<Widget> _children = <Widget>[new SearchFood(), new SearchRecipe()];
    _searchTabController = TabController(vsync: this, length: _tabs.length);

    // Final Modifiers
    _appBarBottom = [
      null,
      new TabBar(
        controller: _searchTabController,
        tabs: _tabs,
      ),
      null,
      null
    ];

    _bodyChildren = [
      Dashboard(),
      Search(tabs: _children, searchTabController: _searchTabController),
      PlaceholderWidget(Colors.green),
      PlaceholderWidget(Colors.red)
    ];
  }

  // When a navigation item is tapped, update the
  // current index to display the correct page.
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('This is an AppBar'),
        bottom: _appBarBottom[_currentIndex],
      ),
      body: _bodyChildren[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          // Search Navigation Bar Item:
          // Navigates to a search page that allows users to
          // search for various food items and append it to
          // their personal list.
          new BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          // My Items Navigation Bar Item:
          // Allows users to view their total nutrition information
          // and edit (remove) items from their existing
          // nutrition list. Users can also save their
          // lists by name for future reference.
          new BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('My Items'),
          ),
          // Profile Navigation Bar Item:
          // TODO
          new BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          )
        ],
      ),
    );
  }
}
