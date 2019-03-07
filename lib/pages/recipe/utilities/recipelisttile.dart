import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:NutriAssistant/pages/recipe/details.dart';

class RecipeListTile extends StatefulWidget {
  RecipeListTile({this.ds});

  final DocumentSnapshot ds;

  @override
  _RecipeListTileState createState() => _RecipeListTileState();
}

class _RecipeListTileState extends State<RecipeListTile> {
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
    return new Card(
      elevation: 0.0,
      child: Center(
        child: new ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipeDetails(
                          recipeItem: widget.ds,
                          type: 'browse',
                        ))).then((dynamic d) {
              setState(() {});
            });
          },
          leading: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(64, 64)),
            child: AspectRatio(
              aspectRatio: 1,
              child: (_loading)
                  ? Material(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Hero(
                      tag: widget.ds['image'],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                          widget.ds['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      )),
            ),
          ),
          title: Text(
            widget.ds['name'],
            style: Theme.of(context).accentTextTheme.title,
          ),
          subtitle: Text(
            widget.ds['subcategory'],
            maxLines: 3,
          ),
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
