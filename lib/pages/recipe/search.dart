import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/recipe/details.dart';
import 'package:nutrition_app_flutter/pages/recipe/itemwidget.dart';

class ResultsSearchPage extends StatefulWidget {
  _ResultsSearchPageState createState() => new _ResultsSearchPageState();
}

class _ResultsSearchPageState extends State<ResultsSearchPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this, length: 3);
    _searchController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//            Container(
//              child: Padding(
//                padding: EdgeInsets.only(top: 28.0),
//                child: new TabBar(
//                  tabs: [
//                    new Tab(
//                      child: Text(
//                        'Standard',
//                      ),
//                    ),
//                    new Tab(
//                      child: Text(
//                        'Healthy',
//                      ),
//                    ),
//                    new Tab(
//                      child: Text(
//                        'Desserts',
//                      ),
//                    )
//                  ],
//                  controller: _tabController,
//                ),
//              ),
//            ),
//            Center(
//              child: Padding(
//                padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
//                child: TextField(
//                  controller: _searchController,
//                  decoration: InputDecoration(
//                      contentPadding: EdgeInsets.all(0.0),
//                      hintText: 'Search',
//                      prefixIcon: Icon(Icons.search),
//                      border: new OutlineInputBorder(
//                          borderRadius: const BorderRadius.all(
//                        const Radius.circular(40.0),
//                      ))),
//                  onSubmitted: (String text) {
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => SearchDetails(query: text)));
//                  },
//                ),
//              ),
//            ),
            Expanded(
              child: new StreamBuilder(
                stream: Firestore.instance
                    .collection('RECIPES')
                    .orderBy('name')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SplashScreenAuth();
                  } else {
                    return new ListView.builder(
                        itemExtent: 130.0,
                        padding: EdgeInsets.all(8.0),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds =
                          snapshot.data.documents[index];
                          return ItemWidget(ds: ds);
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Splash Screen
/// TODO Make a global splash screen
class SplashScreenAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
