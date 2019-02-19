import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/pages/search/foodgroupinfo.dart';
import 'package:nutrition_app_flutter/actions/encrypt.dart';
import 'package:nutrition_app_flutter/storage/fooditem.dart';

/// UI incomplete, details attempts to show nutrition details of some FoodItem
/// as a Dialog
class FoodGroupDetails extends StatefulWidget {
  FoodGroupDetails({this.itemKey});

  String itemKey;

  @override
  _FoodGroupDetailsState createState() =>
      new _FoodGroupDetailsState(itemKey: itemKey);
}

class _FoodGroupDetailsState extends State<FoodGroupDetails> {
  _FoodGroupDetailsState({this.itemKey});

  String itemKey;
  DocumentSnapshot documentSnapshot;

  bool _ready = false;
  bool isFavorited = false;
  FirebaseUser currentUser;
  var stream;

  /// Gathers the data needed to be displayed on this page before
  /// the page is 'ready'
  void doGathering() async {
    DocumentSnapshot querySnapshot = await Firestore.instance
        .collection('ABBREV')
        .document('008P6IqsoekQrFFwES7f')
        .get();
    print('itemkey: ' + itemKey);
    print(querySnapshot);
    print(querySnapshot);
    documentSnapshot = querySnapshot;
    _ready = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    doGathering();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            itemKey,
            style: Theme.of(context).accentTextTheme.title,
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
                splashColor: (!isFavorited) ? Colors.amber : Colors.black12,
                icon: (!isFavorited)
                    ? Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.amber,
                      ),
                onPressed: () async {
//              /// Checking to see if a user can favorite an item or not
//              /// If not, displays a snackbar
//              if (currentUser.isAnonymous) {
//                final snackbar = SnackBar(
//                  content: Text(
//                    'You must register before you can do that!',
//                    style: Theme.of(context).textTheme.body1,
//                  ),
//                  duration: Duration(milliseconds: 1500),
//                );
//                Scaffold.of(context).showSnackBar(snackbar);
//              }
//
//              /// If applicable, update the user's data in Cloud Firestore.
//              ///
//              /// Remove from Firestore
//              if (isFavorited && !currentUser.isAnonymous) {
//                isFavorited = false;
//                if (mounted) {
//                  setState(() {});
//                }
//                await Firestore.instance
//                    .collection("USERS")
//                    .document(Encrypt().encrypt(currentUser.email))
//                    .collection('NUTRIENTS')
//                    .document(
//                        widget.foodItem.detailItems['description']['value'])
//                    .delete();
//              }
//
//              /// Add to Firestore
//              else if (!isFavorited && !currentUser.isAnonymous) {
//                isFavorited = true;
//                if (mounted) {
//                  setState(() {});
//                }
//                await Firestore.instance
//                    .collection("USERS")
//                    .document(Encrypt().encrypt(currentUser.email))
//                    .collection('NUTRIENTS')
//                    .document(
//                        widget.foodItem.detailItems['description']['value'])
//                    .setData(widget.foodItem.toFirestore());
//              }
                })
          ]),
      body: (_ready)
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.black, width: 4.0)),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          'Nutrition Facts',
                          style: TextStyle(
                              fontFamily: 'Franklin Gothic Heavy',
                              fontSize: 32.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                              'Serving Size ' +
                                  documentSnapshot['serving_size_household'] +
                                  ' ' +
                                  documentSnapshot[
                                      'serving_measurement_household'] +
                                  ' (' +
                                  documentSnapshot['serving_size'] +
                                  documentSnapshot['serving_measurement'] +
                                  ')',
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          child: Text('Serving Per Container 2',
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: Colors.black,
                            height: 10.0,
                          ),
                        ),
                        Text(
                          'Amount Per Serving',
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w700),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Calories ',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text('260',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            Text('Calories from Fat 120')
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: Colors.black,
                            height: 5.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('% Daily Value *',
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Total Fat ',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    documentSnapshot['nutrients']['totatfat']
                                            ['value'] +
                                        documentSnapshot['nutrients']
                                            ['totatfat']['measurement'],
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            Text(
                              documentSnapshot['nutrients']['totatfat']
                                      ['daily'] +
                                  '%',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(left: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Saturated Fat ',
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                      documentSnapshot['nutrients']
                                              ['saturated_fat']['value'] +
                                          documentSnapshot['nutrients']
                                              ['saturated_fat']['measurement'],
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                      ))
                                ],
                              ),
                              Text(
                                documentSnapshot['nutrients']['saturated_fat']
                                        ['daily'] +
                                    '%',
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(left: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Trans Fat ',
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                      documentSnapshot['nutrients']['trans_fat']
                                              ['value'] +
                                          documentSnapshot['nutrients']
                                              ['trans_fat']['measurement'],
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                      ))
                                ],
                              ),
                              Text(
                                documentSnapshot['nutrients']['trans_fat']
                                        ['daily'] +
                                    '%',
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Cholesterol ',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    documentSnapshot['nutrients']['cholesterol']
                                            ['value'] +
                                        documentSnapshot['nutrients']
                                            ['cholesterol']['measurement'],
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            Text(
                              documentSnapshot['nutrients']['cholesterol']
                                      ['daily'] +
                                  '%',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Sodium ',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    documentSnapshot['nutrients']['sodium']
                                            ['value'] +
                                        documentSnapshot['nutrients']['sodium']
                                            ['measurement'],
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            Text(
                              documentSnapshot['nutrients']['sodium']['daily'] +
                                  '%',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Total Carbohydrate ',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    documentSnapshot['nutrients']
                                            ['carbohydrate']['value'] +
                                        documentSnapshot['nutrients']
                                            ['carbohydrate']['measurement'],
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            Text(
                              documentSnapshot['nutrients']['carbohydrate']
                                      ['daily'] +
                                  '%',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(left: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Dietary Fiber ',
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                      documentSnapshot['nutrients']['fiber']
                                              ['value'] +
                                          documentSnapshot['nutrients']['fiber']
                                              ['measurement'],
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                      ))
                                ],
                              ),
                              Text(
                                documentSnapshot['nutrients']['fiber']
                                        ['daily'] +
                                    '%',
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(left: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Sugars ',
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                      documentSnapshot['nutrients']['sugar']
                                              ['value'] +
                                          documentSnapshot['nutrients']['sugar']
                                              ['measurement'],
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                      ))
                                ],
                              ),
                              Text(
                                documentSnapshot['nutrients']['sugar']
                                        ['daily'] +
                                    '%',
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Protein ',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    documentSnapshot['nutrients']['protein']
                                            ['value'] +
                                        documentSnapshot['nutrients']['protein']
                                            ['measurement'],
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            Text(
                              documentSnapshot['nutrients']['protein']
                                      ['daily'] +
                                  '%',
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: Colors.black,
                            height: 10.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Vitamin A ',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    documentSnapshot['nutrients']['vitamin_a']
                                            ['daily'] +
                                        '%',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Vitamin C ',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    documentSnapshot['nutrients']['vitamin_c']
                                            ['daily'] +
                                        '%',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Calcium ',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    documentSnapshot['nutrients']['calcium']
                                            ['daily'] +
                                        '%',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Iron ',
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    documentSnapshot['nutrients']['iron']
                                            ['daily'] +
                                        '%',
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            '* Percent Daily Values are based on a 2,000 calorie diet. Your Daily Values may be high or lower depending on your calorie needs',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : SplashScreenAuth(),
    );
  }
}

class SearchDetails extends StatefulWidget {
  SearchDetails({this.query});

  bool _loading = true;
  FirebaseUser currentUser;
  var userNutrients;

  void gatherData() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    userNutrients = (!currentUser.isAnonymous)
        ? await Firestore.instance
            .collection('USERS')
            .document(Encrypt().encrypt(currentUser.email))
            .collection('NUTRIENTS')
            .getDocuments()
        : null;
    _loading = false;
  }

  String query;

  @override
  State<StatefulWidget> createState() {
    gatherData();
    return new _SearchDetailsState();
  }
}

class _SearchDetailsState extends State<SearchDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: (!widget._loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: new StreamBuilder(
                stream: Firestore.instance
                    .collection('ABBREV')
                    .orderBy('description')
                    .where('tokens', arrayContains: widget.query.toLowerCase())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SplashScreenAuth();
                  } else {
                    List<dynamic> verifiedDocs = new List();
                    var docs = snapshot.data.documents;
                    for (int i = 0; i < docs.length; i++) {
                      if (docs[i]['description']
                          .toString()
                          .toLowerCase()
                          .contains(widget.query.toLowerCase())) {
                        verifiedDocs.add(docs[i]);
                      }
                    }
                    return (verifiedDocs.length > 0)
                        ? new ListView.builder(
                            padding: EdgeInsets.all(8.0),
                            itemCount: verifiedDocs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = verifiedDocs[index];
                              FoodItem foodItem = FoodItem(ds);
                              return new ListItem(
                                foodItem: foodItem,
                              );
                            })
                        : Center(
                            child: Text(
                            'No Items Found',
                          ));
                  }
                },
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
