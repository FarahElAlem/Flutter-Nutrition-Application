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
      elevation: 5.0,
      color: Colors.white,
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
          leading: new ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 128, maxWidth: 128),
            child: AspectRatio(
              aspectRatio: 1,
              child: (_loading)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Hero(
                      tag: widget.ds['name'],
                      child: Image.network(
                        widget.ds['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )),
            ),
          ),
          title: Text(widget.ds['name'],
              style: Theme.of(context).textTheme.subhead),
          subtitle: Text(
            widget.ds['subcategory'],
            style: Theme.of(context).textTheme.body1,
            maxLines: 3,
          ),
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
