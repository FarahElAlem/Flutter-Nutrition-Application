import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search/details.dart';
import 'package:nutrition_app_flutter/storage/fooditem.dart';


class NutrientItemWidget extends StatefulWidget {
  NutrientItemWidget({this.ds, this.foodGroupDetails});

  Map<String, dynamic> foodGroupDetails;
  DocumentSnapshot ds;

  @override
  _NutrientItemWidgetState createState() => new _NutrientItemWidgetState(ds: ds, foodGroupDetails: foodGroupDetails);
}

class _NutrientItemWidgetState extends State<NutrientItemWidget> {
  _NutrientItemWidgetState({this.ds, this.foodGroupDetails});

  DocumentSnapshot ds;
  Map<String, dynamic> foodGroupDetails;

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
                  builder: (context) => NutritionItemDetails(
//                        foodItem: FoodItem(widget.ds),
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
