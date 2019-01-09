import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/screens/items.dart';
import 'package:nutrition_app_flutter/screens/profile.dart';
import 'package:nutrition_app_flutter/screens/search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  // Current widget index.
  int _currentIndex = 0;

  // List of children that define the pages
  // that a user sees.
  final List<Widget> _bodyChildren = [Search(), Items(), Profile()];

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
      ),
      body: _bodyChildren[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
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
