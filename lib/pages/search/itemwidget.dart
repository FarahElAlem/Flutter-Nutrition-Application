import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search/foodgroupresult.dart';

class ItemWidget extends StatefulWidget {
  ItemWidget({this.foodGroupNames, this.index, this.foodGroupUrls});

  var foodGroupNames;
  var foodGroupUrls;
  int index;

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  Image _image;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _image = new Image.network(
        widget.foodGroupUrls[widget.foodGroupUrls.keys.toList()[widget.index*2]]);
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
                      foodInformation: widget.foodGroupNames[widget.index],
                      type: 0,
                      foodImage: _image,
                    )));
      },
      splashColor: Colors.transparent,
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
          children: <Widget>[
            Expanded(
              flex: 3,
              child: SizedBox(
                  child: (_loading)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Hero(
                          tag: widget.foodGroupNames[widget.index][0],
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
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                          child: Text(
                            widget.foodGroupNames[widget.index][1],
                            style: Theme.of(context).textTheme.caption,
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
