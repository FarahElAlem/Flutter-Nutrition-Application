import 'dart:convert' as JSON;
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:NutriAssistant/pages/onboarding//title.dart';
import 'package:NutriAssistant/pages/recipe/browse.dart';
import 'package:NutriAssistant/pages/search/browse.dart';
import 'package:NutriAssistant/pages/utility/materialsearch.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _lastIndex = 0;

  bool _ready = false;
  bool _searching = false;

  List<dynamic> nutrientSearchKeys;
  List<dynamic> recipeSearchKeys;

  /// Controller for tabview
  TabController controller;

  /// List of children that define the pages that a user sees. WIP.
  List<Widget> _bodyChildren = [];

  Widget _appBarTitle = new Text('Index');

  /// Placeholder Icon set to a default value, used in the AppBar
  Icon _searchIcon = Icon(Icons.search);

  /// Placeholder Widget set to a default value, used in the AppBar

  /// A list of strings that represent the AppBar titles.
  /// Works nicely with the BottomNavigationBar
  List<String> _appBarTitles = [
    'Browse Nutrition',
    'Browse Recipes',
    'Profile'
  ];

  /// When a navigation item is tapped, update the
  /// current index to display the correct page.
  void onTabTapped(int index) {
    setState(() {
      controller.index = index;
      _currentIndex = index;
      if (_currentIndex == 0 || _currentIndex == 3) {
        _searchIcon = Icon(Icons.search);
      }
    });
  }

  /// Gathers prerequisite data from the Cloud Firestore Database.
  Future<void> _gatherData() async {

    await FirebaseAuth.instance.signInAnonymously();

    String abbrev = await rootBundle.loadString('assets/ABBREV_SEARCH.json');
    nutrientSearchKeys = JSON.jsonDecode(abbrev)['payload'];

    String recipes = await rootBundle.loadString('assets/RECIPES_SEARCH.json');
    recipeSearchKeys = JSON.jsonDecode(recipes)['payload'];

    controller = new TabController(length: 2, vsync: this);

    // Define the children to the tabbed body here
    _bodyChildren = [
      BrowseNutrientPage(
        searchKeys: nutrientSearchKeys,
      ),
      BrowseRecipePage(
        searchKeys: recipeSearchKeys,
      ),
    ];

    sleep(const Duration(seconds: 2));
    _ready = true;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildDashboardAppBar(int _currentIndex, BuildContext context) {
    if (!this._searching || _currentIndex != _lastIndex) {
      this._appBarTitle = new Text(
        _appBarTitles[_currentIndex],
      );
      this._searchIcon = new Icon(Icons.search);
    }

    return _currentIndex < 2
        ? AppBar(
            title: _appBarTitle,
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
              (_currentIndex < 2)
                  ? ((_currentIndex == 0)
                      ? IconButton(
                          icon: _searchIcon,
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: MaterialSearch(
                                  items: nutrientSearchKeys,
                                  type: 'browse-nutrient',
                                ));
                          },
                        )
                      : IconButton(
                          icon: _searchIcon,
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: MaterialSearch(
                                  items: recipeSearchKeys,
                                  type: 'browse-recipe',
                                ));
                          },
                        ))
                  : new Container()
            ],
          )
        : AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          );
  }

  @override
  void initState() {
    super.initState();
    _gatherData();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (!_ready)
        ? new VideoApp()
        : new Scaffold(
            appBar: _buildDashboardAppBar(_currentIndex, context),
            body: new TabBarView(
              physics: new NeverScrollableScrollPhysics(),
              children: _bodyChildren,
              controller: controller,
            ),
            bottomNavigationBar: new Material(
              child: Theme(
                data: Theme.of(context).copyWith(),
                child: new BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: onTabTapped,
                  currentIndex: _currentIndex,
                  items: [
                    /// Search Navigation Bar Item:
                    /// Navigates to a search page that allows users to
                    /// search for various food items and append it to
                    /// their personal list.
                    new BottomNavigationBarItem(
                      icon: _currentIndex == 0
                          ? Icon(
                              Icons.fastfood,
                            )
                          : Icon(
                              Icons.fastfood,
                            ),
                      title: Text(
                        'Nutrition',
                      ),
                    ),

                    /// My Items Navigation Bar Item:
                    /// Allows users to view their total nutrition information
                    /// and edit (remove) items from their existing
                    /// nutrition list. Users can also save their
                    /// lists by name for future reference.
                    new BottomNavigationBarItem(
                      icon: _currentIndex == 1
                          ? Icon(
                              Icons.receipt,
                            )
                          : Icon(
                              Icons.receipt,
                            ),
                      title: Text(
                        'Recipes',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
