import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:nutrition_app_flutter/pages/onboarding//title.dart';
import 'package:nutrition_app_flutter/pages/profile/register.dart';
import 'package:nutrition_app_flutter/pages/recipe/browse.dart';
import 'package:nutrition_app_flutter/pages/recipe/dialog/create_recipe.dart';
import 'package:nutrition_app_flutter/pages/recipe/utilities/materialsearch.dart';
import 'package:nutrition_app_flutter/pages/search/browse.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' as JSON;

import 'package:nutrition_app_flutter/storage/usercache.dart';

class Home extends StatefulWidget {

  final FirebaseStorage storage = FirebaseStorage(
      storageBucket: 'gs://nutrition-app-flutter-5260f.appspot.com');

  final UserCache userCache = new UserCache();

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

    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

    if (!currentUser.isAnonymous) {
      QuerySnapshot snapshotNutrient = await Firestore.instance.collection('USERS').document(currentUser.email).collection('NUTRIENTS').getDocuments();
      QuerySnapshot snapshotRecipe = await Firestore.instance.collection('USERS').document(currentUser.email).collection('RECIPES').getDocuments();

      List<DocumentSnapshot> userDataNutrient = snapshotNutrient.documents;
      List<DocumentSnapshot> userDataRecipe = snapshotRecipe.documents;

      widget.userCache.addAllToFavoriteNutrients(userDataNutrient);
      widget.userCache.addAllToFavoriteRecipes(userDataRecipe);
    }

    String abbrev = await rootBundle.loadString('assets/ABBREV_SEARCH.json');
    nutrientSearchKeys = JSON.jsonDecode(abbrev)['payload'];

    String recipes = await rootBundle.loadString('assets/RECIPES_SEARCH.json');
    recipeSearchKeys = JSON.jsonDecode(recipes)['payload'];

    controller = new TabController(length: 3, vsync: this);

    // Define the children to the tabbed body here
    _bodyChildren = [
      BrowseNutrientPage(
        userCache: widget.userCache,
        searchKeys: nutrientSearchKeys,
      ),
      BrowseRecipePage(
        userCache: widget.userCache,
        searchKeys: recipeSearchKeys,
      ),
      RegisterPage(userCache: widget.userCache)
    ];

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
                  ? ((_currentIndex == 0) ? IconButton(
                icon: _searchIcon,
                onPressed: () {
                  showSearch(context: context,
                      delegate: MaterialSearch(items: nutrientSearchKeys, type: 'browse-nutrient'));
                },
              ) : IconButton(
                icon: _searchIcon,
                onPressed: () {
                  showSearch(context: context,
                      delegate: MaterialSearch(items: recipeSearchKeys, type: 'browse-recipe'));
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

  Widget _buildDrawer(int _currentIndex, BuildContext context) {
    return _currentIndex < 2
        ? SizedBox(
            width: 190.0,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text('Drawer Header'),
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                    },
                  ),
                ],
              ),
            ),
          )
        : null;
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
            floatingActionButton: (_currentIndex == 1)
                ? FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecipeCreate(searchKeys: nutrientSearchKeys,)));
                    },
                    icon: Icon(Icons.create),
                    label: Text('Create\nRecipe'),
                  )
                : null,
            drawer: _buildDrawer(_currentIndex, context),
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

                    /// Profile Navigation Bar Item:
                    /// TODO
                    new BottomNavigationBarItem(
                      icon: _currentIndex == 2
                          ? Icon(
                              Icons.account_circle,
                            )
                          : Icon(
                              Icons.account_circle,
                            ),
                      title: Text(
                        'Profile',
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
