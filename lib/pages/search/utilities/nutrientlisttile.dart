import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:NutriAssistant/pages/search//details.dart';

class NutrientListTile extends StatefulWidget {
  NutrientListTile({this.ds});

  final DocumentSnapshot ds;

  @override
  _NutrientListTileState createState() => _NutrientListTileState();
}

class _NutrientListTileState extends State<NutrientListTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.transparent,
      elevation: 0.0,
      child: Center(
        child: new ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NutrientDetails(
                          itemKey: widget.ds['description'],
                        ))).then((dynamic d) {
              setState(() {});
            });
            ;
          },
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.ds['description'],
              style: Theme.of(context).accentTextTheme.title,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.ds['manufacturer'],
              maxLines: 1,
            ),
          ),
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
