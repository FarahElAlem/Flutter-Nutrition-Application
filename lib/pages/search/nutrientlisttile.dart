import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search//details.dart';

class NutrientListTile extends StatefulWidget {
  NutrientListTile({this.ds});

  var ds;

  @override
  _NutrientListTileState createState() => _NutrientListTileState();
}

class _NutrientListTileState extends State<NutrientListTile> {
  bool _loading;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Center(
        child: new ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NutritionItemDetails(
                      itemKey: widget.ds['description'],
                    )));
          },
          title: Text(widget.ds['description'], style: Theme.of(context).accentTextTheme.title,),
          subtitle: Text(
            widget.ds['manufacturer'],
            maxLines: 1,
          ),
          trailing: IconButton(icon: Icon(Icons.favorite_border), onPressed: (){}),
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
