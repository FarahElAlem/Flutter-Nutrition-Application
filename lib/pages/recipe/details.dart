import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/globals.dart';
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: getHeadingText(recipeItem['name'],
                          textAlign: TextAlign.center),
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
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 25.0,
                    ),
                    Center(
                      child: getDetailsText(recipeItem['description'],
                          textAlign: TextAlign.center),
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 25.0,
                    ),
                    getSubHeadingText('Ingredients',
                        textAlign: TextAlign.start),
                    Divider(
                      height: 1.0,
                      color: Colors.black,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: recipeItem['ingredients'].length,
                        padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                title: getDetailsText(
                                    recipeItem['ingredients'][index]),
                              ),
                            ],
                          );
                        }),
                    getSubHeadingText('Directions', textAlign: TextAlign.start),
                    Divider(
                      height: 1.0,
                      color: Colors.black,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: recipeItem['directions'].length,
                        padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 1.0,
                            color: Colors.white70,
                            child: ListTile(
                              contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                              leading: getDetailsText((index + 1).toString(),
                                  color: Colors.green),
                              title: Align(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: getDetailsText(
                                      recipeItem['directions'][index]),
                                ),
                                alignment: Alignment(-80.0, 0),
                              ),
                            ),
                          );
                        })
                  ]),
            ),
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
            getHeadingText('Results For: ' + widget.query, color: Colors.white),
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
