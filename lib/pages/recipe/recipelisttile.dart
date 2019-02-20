import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/recipe/details.dart';

class RecipeListTile extends StatefulWidget {
  RecipeListTile({this.ds});

  var ds;

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
      child: Center(
        child: new ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Details(
                          recipeItem: widget.ds,
                        )));
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
                  tag: widget.ds['name'],
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
          title: Text(widget.ds['name'], style: Theme.of(context).accentTextTheme.title,),
          subtitle: Text(
            widget.ds['subcategory'],
            maxLines: 3,
          ),
          trailing: IconButton(icon: Icon(Icons.favorite_border), onPressed: (){}),
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
