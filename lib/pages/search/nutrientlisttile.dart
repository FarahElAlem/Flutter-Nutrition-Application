import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search//details.dart';
import 'package:nutrition_app_flutter/storage/usercache.dart';

class NutrientListTile extends StatefulWidget {
  NutrientListTile({this.ds, this.userCache});

  final DocumentSnapshot ds;
  final UserCache userCache;

  @override
  _NutrientListTileState createState() => _NutrientListTileState();
}

class _NutrientListTileState extends State<NutrientListTile> {
  bool _isFavorited = false;

  @override
  void initState() {
    _isFavorited =
        widget.userCache.isInFavoriteNutrients(widget.ds['description']);
    super.initState();
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
                    builder: (context) => NutritionItemDetails(
                          itemKey: widget.ds['description'],
                        )));
          },
          title: Text(
            widget.ds['description'],
            style: Theme.of(context).accentTextTheme.title,
          ),
          subtitle: Text(
            widget.ds['manufacturer'],
            maxLines: 1,
          ),
          trailing: IconButton(
              icon: (_isFavorited)
                  ? Icon(
                      Icons.favorite,
                      color: Colors.amber,
                    )
                  : Icon(Icons.favorite_border),
              onPressed: () async {
                FirebaseUser currentUser =
                    await FirebaseAuth.instance.currentUser();

                if (!currentUser.isAnonymous && _isFavorited) {
                  widget.userCache
                      .removeFromFavoriteNutrients(widget.ds['description']);
                  if (mounted) {
                    setState(() {
                      _isFavorited = !_isFavorited;
                    });
                  }
                } else if (!currentUser.isAnonymous && !_isFavorited) {
                  widget.userCache..addToFavoriteNutrients(widget.ds.data);
                  if (mounted) {
                    setState(() {
                      _isFavorited = !_isFavorited;
                    });
                  }
                } else if (currentUser.isAnonymous) {
                  final snackbar = SnackBar(
                    content:
                        Text('You must sign-in before you can favorite items!'),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                }
              }),
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
