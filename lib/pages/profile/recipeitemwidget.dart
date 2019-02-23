import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/recipe/details.dart';
import 'package:nutrition_app_flutter/storage/usercache.dart';

class RecipeItemWidget extends StatefulWidget {
  RecipeItemWidget({this.ds, this.userCache});

  final Map<String, dynamic> ds;
  final UserCache userCache;

  @override
  _RecipeItemWidgetState createState() => new _RecipeItemWidgetState();
}

class _RecipeItemWidgetState extends State<RecipeItemWidget> {
  Image _image;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _image = new Image.network(widget.ds['image']);
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
                  builder: (context) => RecipeDetails(
                    recipeItem: widget.ds,
                    userCache: widget.userCache,
                  )));
        },
        child: SizedBox.shrink(
          child: new Card(
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.0, right: 2.0),
                        child: Center(
                          child: Text(
                            widget.ds['name'],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ))
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
