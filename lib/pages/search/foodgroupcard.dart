import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search/foodgroupinfo.dart';

class FoodGroupCard extends StatefulWidget {
  FoodGroupCard({this.foodItemInformation});

  Map<String, dynamic> foodItemInformation;
  String foodKey;

  @override
  _FoodGroupCardState createState() =>
      _FoodGroupCardState(foodItemInformation: foodItemInformation);
}

class _FoodGroupCardState extends State<FoodGroupCard> {
  _FoodGroupCardState({this.foodItemInformation});

  Map<String, dynamic> foodItemInformation;

  Image _image;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _image = new Image.network(foodItemInformation['url']);
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
    return new InkWell(
      onTap: () {
        /// onTap(): creates a results page full of different nutrient items from the food group selected
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodGroupResult(
                      foodItemInformation: foodItemInformation,
                    )));
      },
      splashColor: Colors.transparent,
      child: new Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: SizedBox(
                  child: (_loading)
                      ? Material(
                    child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Hero(
                          tag: foodItemInformation,
                          child: new Container(
                            decoration: new BoxDecoration(
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    alignment: FractionalOffset.topCenter,
                                    image: _image.image)),
                          ))),
            ),
            Expanded(
                flex: 1,
                child: SizedBox.expand(
                  child: Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                          child: Text(
                            foodItemInformation['name'],
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
