import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/globals.dart';

class ResultsSearchPage extends StatefulWidget {
  _ResultsSearchPageState createState() => new _ResultsSearchPageState();
}

Widget _buildFirebaseStream(String category) {
  return new StreamBuilder(
    stream: Firestore.instance
        .collection('RECIPES')
        .where('category', isEqualTo: category)
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
              DocumentSnapshot ds = snapshot.data.documents[index];
              return new Card(
                elevation: 5.0,
                color: Colors.white,
                child: Center(
                  child: new ListTile(
                    onTap: (){},
                    leading: new ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 96, maxWidth: 96),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          ds['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    title: getSubHeadingText(ds['name']),
                    subtitle: getIconText(ds['description'], maxLines: 3),
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              );
            });
      }
    },
  );
}

class _ResultsSearchPageState extends State<ResultsSearchPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Tab> _tabs = [
    new Tab(
      child: getDetailsText('Standard'),
    ),
    new Tab(
      child: getDetailsText('Healthy'),
    ),
    new Tab(
      child: getDetailsText('Desserts'),
    )
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new TabBar(
        tabs: _tabs,
        controller: _tabController,
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildFirebaseStream('Standard'),
          _buildFirebaseStream('Healthy'),
          _buildFirebaseStream('Desserts'),
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
