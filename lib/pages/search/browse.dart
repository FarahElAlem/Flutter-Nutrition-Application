import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/profile/profile.dart';
import 'package:nutrition_app_flutter/pages/search/nutrientlisttile.dart';
//import 'package:nutrition_app_flutter/pages/profile /profile.dart';

class BrowseNutrientPage extends StatefulWidget {
  @override
  _BrowseNutrientPageState createState() => _BrowseNutrientPageState();
}

class _BrowseNutrientPageState extends State<BrowseNutrientPage> {
  bool _isFetching = false;
  bool _nomore = false;

  bool _ready = false;

  List<Widget> _browseItems = new List<Widget>();
  DocumentSnapshot _lastDocument;
  ScrollController _controller;

  void _fetchDocuments() async {
    final QuerySnapshot querySnapshot = await Firestore.instance
        .collection('ABBREV')
        .orderBy('description')
        .startAfter(['100% Apple Juice'])
        .limit(10)
        .getDocuments();
    _lastDocument = querySnapshot.documents.last;
    List<Widget> items = new List();
    for (final DocumentSnapshot snapshot in querySnapshot.documents) {
      items.add(NutrientListTile(ds: snapshot));
    }
    items.add(Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    ));
    _ready = true;
    setState(() {
      _browseItems.addAll(items);
    });
  }

  Future<void> _fetchFromLast() async {
    final QuerySnapshot querySnapshot = await Firestore.instance
        .collection('ABBREV')
        .orderBy('description')
        .startAfter([_lastDocument['description']])
        .limit(10)
        .getDocuments();
    if (querySnapshot.documents.length < 4) {
      _nomore = true;
      return;
    }
    _browseItems.removeLast();
    _lastDocument = querySnapshot.documents.last;
    List<Widget> items = new List();
    for (final DocumentSnapshot snapshot in querySnapshot.documents) {
      items.add(NutrientListTile(ds: snapshot));
    }
    items.add(Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    ));
    print('Length of BrowseItems: ' + _browseItems.length.toString());
    setState(() {
      _browseItems.addAll(items);
    });
  }

  void _scrollListener() async {
    if (_nomore) return;
    if (_controller.position.pixels == _controller.position.maxScrollExtent/1.25 &&
        _isFetching == false) {
      _isFetching = true;
      await _fetchFromLast();
      _isFetching = false;
    }
  }

  @override
  void initState() {
    _fetchDocuments();
    _controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_ready)
        ? Container(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              controller: _controller,
              itemCount: _browseItems.length,
              itemBuilder: (BuildContext context, int index) {
                return _browseItems[index];
              },
            ))
        : SplashScreenAuth();
  }
}
