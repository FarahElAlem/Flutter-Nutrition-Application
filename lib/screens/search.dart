import 'package:flutter/material.dart';


class Search extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new TextField(
            onSubmitted: null,
            decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...',
            ),
          ),
        ));
  }
}
