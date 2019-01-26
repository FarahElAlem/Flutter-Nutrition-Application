import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// class Dashboard creates a StaggeredGridView of menu items for
/// the user in a fun-like fashion. TODO a lot needs to be customized here.
class Dashboard extends StatelessWidget {
  Dashboard({this.firestore});

  Firestore firestore;

  // Width, Height
  List<StaggeredTile> _staggeredTiles = [
    const StaggeredTile.count(4, 2),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(4, 2),
  ];

  // Todo: Design Cards based on attributes
  List<Widget> _tiles = <Widget>[
    Card(
      color: Colors.blue,
      child: new Center(
        child: new ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Your Account Status Here'),
          subtitle: Text('More things!'),
        ),
      ),
    ),
    Card(
      color: Colors.red,
      child: new Center(
        child: new ListTile(
          leading: Icon(Icons.announcement),
          title: Text('News goes here!'),
          subtitle: Text('Some interesting stories out there...'),
        ),
      ),
    ),
    Card(
      color: Colors.amber,
      child: new Center(
        child: new ListTile(
          leading: Icon(Icons.computer),
          title: Text('Hey we also have a webapp!'),
          subtitle: Text('Wait do we have a webapp?'),
        ),
      ),
    ),
    Card(
      color: Colors.green,
      child: new Center(
        child: new ListTile(
          leading: Icon(Icons.new_releases),
          title: Text('Checkout some of our new stuff!'),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new StaggeredGridView.count(
      crossAxisCount: 4,
      staggeredTiles: _staggeredTiles,
      children: _tiles,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      padding: const EdgeInsets.all(4.0),
    );
  }
}
