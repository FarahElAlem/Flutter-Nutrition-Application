import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/recipe/details.dart';

class ItemWidget extends StatefulWidget {
  ItemWidget({this.ds});

  var ds;

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
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
          leading: AspectRatio(
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
          title: Text(widget.ds['name'], style: Theme.of(context).accentTextTheme.title,),
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
