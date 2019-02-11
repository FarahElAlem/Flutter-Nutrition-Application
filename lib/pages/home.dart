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

  /// Controller for tabview
  TabController controller;

  /// foodGroupDetails[key][0] = Number
  /// foodGroupDetails[key][1] = Name
  /// foodGroupDetails[key][2] = Description
  /// foodGroupDetails[key][3] = URL
  Map<String, dynamic> foodGroupDetails = new Map();

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
  List<String> _appBarTitles = ['Nutrition', 'Recipes', 'Profile'];

  /// A list of widgets to represent the leading icons of the AppBar.
  /// Works nicely with the BottomNavigationBar
  List<Widget> _leadingIcons = [
    new Icon(Icons.fastfood),
    new Icon(Icons.receipt),
    null
  ];

  /// When a navigation item is tapped, update the
  /// current index to display the correct page.
  void onTabTapped(int index) {
    setState(() {
      controller.index = index;
      _currentIndex = index;
      if (_currentIndex == 0 || _currentIndex == 3) {
        _isSearching = false;
        _searchIcon = Icon(Icons.search);
      }
    });
  }

  /// Gathers prerequisite data from the Cloud Firestore Database.
  Future<void> _gatherData() async {
    /// Gather our NUTRITION information from Firestore here
    QuerySnapshot foodGroupSnapshot = await Firestore.instance
        .collection('FOODGROUP')
        .orderBy('FdGrp_Desc')
        .getDocuments();

    for (DocumentSnapshot doc in foodGroupSnapshot.documents) {
      var url = await widget.storage
          .ref()
          .child(doc['FdGrp_Desc'].replaceAll(' ', '').replaceAll('/', '') + '.png')
          .getDownloadURL();
      foodGroupDetails[doc['Fd_Grp']] = {
        'name': doc['FdGrp_Desc'],
        'foodgroup': doc['Fd_Grp'],
        'description': doc['Paragraph'],
        'url': url.toString()
      };
    }
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
//            appBar: _buildDashboardAppBar(),
            body: new TabBarView(
              physics: new NeverScrollableScrollPhysics(),
              children: _bodyChildren,
              controller: controller,
            ),
            bottomNavigationBar: new BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                /// Search Navigation Bar Item:
                /// Navigates to a search page that allows users to
                /// search for various food items and append it to
                /// their personal list.
                new BottomNavigationBarItem(
                  icon: Icon(Icons.fastfood),
                  title: Text(
                    'Nutrition',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),

                /// My Items Navigation Bar Item:
                /// Allows users to view their total nutrition information
                /// and edit (remove) items from their existing
                /// nutrition list. Users can also save their
                /// lists by name for future reference.
                new BottomNavigationBarItem(
                  icon: Icon(Icons.receipt),
                  title: Text(
                    'Recipes',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),

                /// Profile Navigation Bar Item:
                /// TODO
                new BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  title: Text(
                    'Profile',
                    style: Theme.of(context).textTheme.caption,
                  ),
                )
              ],
            ),
          );
  }
}
