import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search/details.dart';
import 'package:nutrition_app_flutter/structures/fooditem.dart';


class NutrientItemWidget extends StatefulWidget {
  NutrientItemWidget({this.ds, this.foodGroupUrls});

  Map<String, String> foodGroupUrls;
  DocumentSnapshot ds;

  @override
  _NutrientItemWidgetState createState() => new _NutrientItemWidgetState();
}

class _NutrientItemWidgetState extends State<NutrientItemWidget> {
  Image _image;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _image = new Image.network(widget.foodGroupUrls[widget.ds['foodgroup']]);
    _loading = true;
    _image.image.resolve(new ImageConfiguration()).addListener((_, __) async {
      _loading = false;
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoodGroupDetails(
                        foodItem: FoodItem(widget.ds),
                      )));
        },
        child: SizedBox.shrink(
          child: new Card(
            color: Colors.white,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                flex: 3,
                child: SizedBox(
                    child: (_loading)
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : new Container(
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.topCenter,
                              image: _image.image)),
                    )),
                ),
                Expanded(
                    flex: 1,
                    child: Material(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Center(
                          child: Text(
                            widget.ds['description'],
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
      height: 256.0,
      width: 256.0,
    );
  }
}
