import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search/details.dart';
import 'package:nutrition_app_flutter/storage/fooditem.dart';
import 'package:nutrition_app_flutter/storage/usercache.dart';


class NutrientItemWidget extends StatefulWidget {
  NutrientItemWidget({this.ds, this.userCache});

  final Map<String, dynamic> ds;
  final UserCache userCache;

  @override
  _NutrientItemWidgetState createState() => new _NutrientItemWidgetState(ds: ds);
}

class _NutrientItemWidgetState extends State<NutrientItemWidget> {
  _NutrientItemWidgetState({this.ds});

  Map<String, dynamic> ds;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NutrientDetails(
                    itemKey: ds['description'],
                    userCache: widget.userCache,
                  )));
        },
        child: SizedBox.shrink(
          child: new Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              Center(
                child: Material(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Center(
                      child: Text(
                        widget.ds['description'],
                        textAlign: TextAlign.center,
                        maxLines: 4,
                      ),
                    ),
                  ),
                ),
              )
              ],
            ),
          ),
        ),
      ),
      height: 144.0,
      width: 256.0,
    );
  }
}
