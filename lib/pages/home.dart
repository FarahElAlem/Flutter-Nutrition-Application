import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/demo/placeholder.dart';
import 'package:nutrition_app_flutter/pages/dashboard/dashboard.dart';
import 'package:nutrition_app_flutter/pages/profile/login.dart';
import 'package:nutrition_app_flutter/pages/search/result.dart';
import 'package:nutrition_app_flutter/pages/search/search.dart';

class Home extends StatefulWidget {
  Home({this.currentUser});

  Firestore firestore = Firestore.instance;
  FirebaseUser currentUser;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  /// Current widget index.
  int _currentIndex = 0;

  /// List of foodgroupnames for subpages
  List<List<String>> foodGroupNames = [];

  /// List of children that define the pages that a user sees. WIP.
  List<Widget> _bodyChildren = [];

  /// This is used so that the AppBar can determine whether or not to
  /// display the correct information when searching.
  bool _isSearching = false;

  /// Placeholder Icon set to a default value, used in the AppBar
  Icon _searchIcon = Icon(Icons.search);

  /// Placeholder Widget set to a default value, used in the AppBar
  Widget _appBarTitle = new Center(child: new Text('Dashboard'));

  /// A list of strings that represent the AppBar titles.
  /// Works nicely with the BottomNavigationBar
  List<String> _appBarTitles = [
    'Dashboard',
    'Search Nutrition',
    'Search Recipes',
    'Profile'
  ];

  /// A list of widgets to represent the leading icons of the AppBar.
  /// Works nicely with the BottomNavigationBar
  List<Widget> _leadingIcons = [
    null,
    new Icon(Icons.fastfood),
    new Icon(Icons.receipt),
    null
  ];

  /// When a navigation item is tapped, update the
  /// current index to display the correct page.
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0 || _currentIndex == 3) {
        _isSearching = false;
        _searchIcon = Icon(Icons.search);
      }
    });
  }

  Widget _buildSearchBar() {
    return new IconButton(
        icon: _searchIcon,
        onPressed: () {
          setState(() {
            if (this._searchIcon.icon == Icons.search) {
              this._isSearching = true;
              this._searchIcon = new Icon(Icons.close);
              this._appBarTitle = new TextField(
                  onSubmitted: (token) {
                    this._isSearching = false;
                    this._searchIcon = new Icon(Icons.search);
                    this._appBarTitle = new Center(
                      child: new Text(_appBarTitles[_currentIndex]),
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Result(token: token.toString(), type: 1)));
                  },
                  decoration: new InputDecoration(hintText: 'Search...'));
            } else {
              this._isSearching = false;
              this._searchIcon = new Icon(Icons.search);
              this._appBarTitle = new Center(
                child: new Text(_appBarTitles[_currentIndex]),
              );
            }
          });
        });
  }

  /// Returns the correct AppBar depending on which page the user has
  /// navigated to through the BottomNavigationBar. Contains a icon button
  /// that displays a search bar on the correct search pages inside the AppBar.
  Widget _buildDashboardAppBar() {
    return new AppBar(
      leading: _leadingIcons[_currentIndex],
      title: (!_isSearching)
          ? new Center(
              child: new Text(_appBarTitles[_currentIndex]),
            )
          : _appBarTitle,
      actions: <Widget>[
        (_currentIndex == 1 || _currentIndex == 2)
            ? _buildSearchBar()
            : new Container(
                width: 0,
                height: 0,
              )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    widget.firestore.settings(persistenceEnabled: true);

    // Define the children to the tabbed body here
    _bodyChildren = [
      Dashboard(firestore: widget.firestore),
      Search(foodGroupNames: foodGroupNames, firestore: widget.firestore, currentUser: widget.currentUser),
      PlaceholderWidget(Colors.green),
      LoginPage(firestore: widget.firestore, currentUser: widget.currentUser)
    ];

    // Gather our information from firestore here
    Firestore.instance
        .collection('FOODGROUP')
        .orderBy('FdGrp_Desc')
        .getDocuments()
        .then((data) => data.documents.forEach((doc) {
              foodGroupNames.add([doc['Fd_Grp'], doc['FdGrp_Desc']]);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildDashboardAppBar(),
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

          /// Search Navigation Bar Item:
          /// Navigates to a search page that allows users to
          /// search for various food items and append it to
          /// their personal list.
          new BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('Nutrition'),
          ),

          /// My Items Navigation Bar Item:
          /// Allows users to view their total nutrition information
          /// and edit (remove) items from their existing
          /// nutrition list. Users can also save their
          /// lists by name for future reference.
          new BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            title: Text('Recipes'),
          ),

          /// Profile Navigation Bar Item:
          /// TODO
          new BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          )
        ],
      ),
    );
  }
}
