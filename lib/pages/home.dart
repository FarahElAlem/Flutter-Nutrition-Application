import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/dashboard/title.dart';

import 'package:nutrition_app_flutter/pages/profile/register.dart';
import 'package:nutrition_app_flutter/pages/recipe/search.dart';
import 'package:nutrition_app_flutter/pages/search/search.dart';

class Home extends StatefulWidget {
  Home({this.currentUser, this.firestore});

  Firestore firestore;
  final FirebaseStorage storage = FirebaseStorage(
      storageBucket: 'gs://nutrition-app-flutter-5260f.appspot.com');
  FirebaseUser currentUser;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  /// Current widget index.
  int _currentIndex = 0;

  bool _ready = false;

  bool _searching = false;

  int _lastIndex = 0;

  /// Controller for tabview
  TabController controller;

  TextEditingController _searchController = new TextEditingController();

  /// foodGroupDetails[key][0] = Number
  /// foodGroupDetails[key][1] = Name
  /// foodGroupDetails[key][2] = Description
  /// foodGroupDetails[key][3] = URL
  Map<String, dynamic> foodGroupDetails = new Map();

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
    QuerySnapshot foodGroupSnapshot = await Firestore.instance
        .collection('FOODGROUP')
        .orderBy('FdGrp_Desc')
        .getDocuments();

    for (DocumentSnapshot doc in foodGroupSnapshot.documents) {
      var url = await widget.storage
          .ref()
          .child(doc['FdGrp_Desc'].replaceAll(' ', '').replaceAll('/', '') +
              '.png')
          .getDownloadURL();
      foodGroupDetails[doc['Fd_Grp']] = {
        'name': doc['FdGrp_Desc'],
        'foodgroup': doc['Fd_Grp'],
        'description': doc['Paragraph'],
        'url': url.toString()
      };
    }
  }

  Widget _buildDashboardAppBar(int _currentIndex, BuildContext context) {
    if (!this._searching || _currentIndex != _lastIndex) {
      this._appBarTitle = new Text(
        _appBarTitles[_currentIndex],
        style: Theme.of(context).textTheme.subhead,
      );
      this._searchIcon = new Icon(Icons.search);
    }

    return _currentIndex < 2
        ? AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: _appBarTitle,
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
              (_currentIndex < 2)
                  ? IconButton(
                      icon: _searchIcon,
                      onPressed: () {
                        setState(() {
                          this._lastIndex = _currentIndex;
                          if (this._searchIcon.icon == Icons.search) {
                            this._searching = true;
                            this._searchIcon = new Icon(Icons.close);
                            this._appBarTitle = new TextField(
                              controller: _searchController,
                              style: Theme.of(context).textTheme.body1,
                              decoration: new InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  hintText: 'Search...'),
                            );
                          } else {
                            this._searching = false;
                            this._searchIcon = new Icon(Icons.search);
                            this._appBarTitle = new Text(
                              _appBarTitles[_currentIndex],
                              style: Theme.of(context).textTheme.subhead,
                            );
                          }
                        });
                      },
                    )
                  : new Container()
            ],
          )
        : PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Container(),
          );
  }

  Widget _buildDrawer(int _currentIndex, BuildContext context) {
    return _currentIndex < 2
        ? Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
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
                  leading: Icon(Icons.stop),
                  title: Text('Logout'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                  },
                ),
              ],
            ),
          )
        : null;
  }

  @override
  void initState() {
    super.initState();

    controller = new TabController(length: 3, vsync: this);

    // Define the children to the tabbed body here
    _bodyChildren = [
      Search(foodGroupDetails: foodGroupDetails),
      ResultsSearchPage(),
      RegisterPage(
        foodGroupDetails: foodGroupDetails,
      )
    ];

    _gatherData().whenComplete(() {
      print(foodGroupDetails.toString());
      _ready = true;
      if (mounted) {
        setState(() {});
      }
    });
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
            drawer: _buildDrawer(_currentIndex, context),
            body: new TabBarView(
              physics: new NeverScrollableScrollPhysics(),
              children: _bodyChildren,
              controller: controller,
            ),
            bottomNavigationBar: new Material(
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Theme.of(context).primaryColor,
                ),
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
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.fastfood,
                              color: Colors.white54,
                            ),
                      title: Text(
                        'Nutrition',
                        style: _currentIndex == 0
                            ? TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                                color: Colors.white)
                            : TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                                color: Colors.white54),
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
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.receipt,
                              color: Colors.white54,
                            ),
                      title: Text(
                        'Recipes',
                        style: _currentIndex == 1
                            ? TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                                color: Colors.white)
                            : TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                                color: Colors.white54),
                      ),
                    ),

                    /// Profile Navigation Bar Item:
                    /// TODO
                    new BottomNavigationBarItem(
                      icon: _currentIndex == 2
                          ? Icon(
                              Icons.account_circle,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.account_circle,
                              color: Colors.white54,
                            ),
                      title: Text(
                        'Profile',
                        style: _currentIndex == 2
                            ? TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                                color: Colors.white)
                            : TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                                color: Colors.white54),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
