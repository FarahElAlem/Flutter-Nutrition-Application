import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatelessWidget {
  // Width, Height
  List<StaggeredTile> _staggeredTiles = [
    const StaggeredTile.count(4, 2),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(3, 2),
    const StaggeredTile.count(1, 2),
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
    Card(
      color: Colors.purple,
      child: new Center(
        child: new ListTile(
          title: Text('I exist!'),
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
