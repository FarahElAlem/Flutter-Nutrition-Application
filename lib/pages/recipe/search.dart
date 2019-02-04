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

  List<Tab> _tabs;

  @override
  void initState() {
    super.initState();

    _tabs = [
      new Tab(
        child: Text('Standard', style: Theme.of(this.context).textTheme.body1,),
      ),
      new Tab(
        child: Text('Healthy', style: Theme.of(this.context).textTheme.body1,),
      ),
      new Tab(
        child: Text('Desserts', style: Theme.of(this.context).textTheme.body1,),
      )
    ];

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
      appBar: new TabBar(
        tabs: _tabs,
        controller: _tabController,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
              child: TextField(
//                style: detailsTextStyleInput,
                controller: _searchController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ))),
                onSubmitted: (String text) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchDetails(query: text)));
                },
              ),
            ),
          ),
          Expanded(
            child: new TabBarView(
              controller: _tabController,
              children: <Widget>[
                new StreamBuilder(
                  stream: Firestore.instance
                      .collection('RECIPES')
                      .where('category', isEqualTo: 'Standard')
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
                new StreamBuilder(
                  stream: Firestore.instance
                      .collection('RECIPES')
                      .where('category', isEqualTo: 'Healthy')
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
                new StreamBuilder(
                  stream: Firestore.instance
                      .collection('RECIPES')
                      .where('category', isEqualTo: 'Desserts')
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
                )
              ],
            ),
          )
        ],
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
