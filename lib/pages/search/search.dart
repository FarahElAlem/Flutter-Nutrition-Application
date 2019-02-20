import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';

/// class Search represents a Stateful widget that can have multiple states:
/// - Seeking / Searching:
///     - Consists of a StaggeredGridView of elements gathered from Firebase.
/// - Result Gathering
///     - Result of a query gathered from Firebase that users can interact with.
class Search extends StatefulWidget {
  Search({this.abbrevItems});

  Map<String, dynamic> abbrevItems;

  @override
  _SearchState createState() =>
      _SearchState(abbrevItems: abbrevItems);
}

class _SearchState extends State<Search> {
  _SearchState({this.abbrevItems});

  Map<String, dynamic> abbrevItems;

  TextEditingController _searchController;

  @override
  void initState() {
    _searchController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  /// TODO make db images 256px or 128px
  @override
  Widget build(BuildContext context) {
//    return new MaterialSearch<String>(
//      placeholder: 'Search',
//      leading: Icon(Icons.search),
//      results: abbrevItems.keys.map((name) => new MaterialSearchResult<String>(
//        value: name, //The value must be of type <String>
//        text: name, //String that will be show in the list
//        subtitle: abbrevItems[name]['manufacturer'],
//        icon: Icons.fastfood,
//      )).toList(),
//
//    );
  }
}
