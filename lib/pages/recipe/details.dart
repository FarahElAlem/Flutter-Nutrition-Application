import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/recipe/itemwidget.dart';

/// UI incomplete, details attempts to show nutrition details of some FoodItem
/// as a Dialog
class Details extends StatelessWidget {
  Details({this.recipeItem});

  var recipeItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(),
        body: LayoutBuilder(
            builder: (BuildContext contest, BoxConstraints constraintss) {
          return SingleChildScrollView(
              child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraintss.maxHeight),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 0),
                    child: Center(
                      child: Text(recipeItem['name'], style: Theme.of(context).textTheme.headline,),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 25.0,
                  ),
                  Hero(
                    tag: recipeItem['image'],
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        recipeItem['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 25.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(recipeItem['description'], style: Theme.of(context).textTheme.body1,),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 25.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ingredients', style: Theme.of(context).textTheme.subhead,),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      height: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipeItem['ingredients'].length,
                      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(recipeItem['ingredients'][index], style: Theme.of(context).textTheme.body1,),
                            ),
                          ],
                        );
                      }),
                  Container(
                    color: Colors.black12,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Directions', style: Theme.of(context).textTheme.subhead,),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: recipeItem['directions'].length,
                              padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 3.0,
                                  color: Colors.white,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        32.0, 8.0, 56.0, 8.0),
                                    leading: Text((index + 1).toString(), style: Theme.of(context).textTheme.body2,),
                                    title: Align(
                                      child: Text(recipeItem['directions'][index], style: Theme.of(context).textTheme.body1,),
//                                alignment: Alignment(-80.0, 0),
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  )
                ]),
          ));
        }));
  }
}

class SearchDetails extends StatefulWidget {
  SearchDetails({this.query});

  String query;

  @override
  _SearchDetailsState createState() => new _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
  List<Object> objs;

  bool _loading = true;

  void gatherData() async {
    var docs = await Firestore.instance.collection('RECIPES').getDocuments();

    objs = new List();

    docs.documents.forEach((DocumentSnapshot snapshot) {
      if (snapshot.data['name']
              .toString()
              .toLowerCase()
              .contains(widget.query) ||
          listContains(
              snapshot.data['ingredients'], widget.query.toLowerCase())) {
        objs.add(snapshot);
      }
    });
    _loading = false;
    setState(() {});
  }

  bool listContains(List<dynamic> list, var query) {
    for (int i = 0; i < list.length; i++) {
      if (list[i]
          .toString()
          .toLowerCase()
          .contains(query..toString().toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    gatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Results For: ' + widget.query, style: Theme.of(context).textTheme.headline,),
        centerTitle: true,
      ),
      body: (_loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemExtent: 130.0,
              padding: EdgeInsets.all(8.0),
              itemCount: objs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = objs[index];
                return ItemWidget(ds: ds);
              }),
    );
  }
}
