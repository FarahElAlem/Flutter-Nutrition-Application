import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:NutriAssistant/pages/utility/splash.dart';

/// UI incomplete, details attempts to show nutrition details of some FoodItem
/// as a Dialog
class NutrientDetails extends StatefulWidget {
  NutrientDetails({this.itemKey});

  final String itemKey;

  @override
  _NutrientDetailsDetailState createState() =>
      new _NutrientDetailsDetailState(itemKey: itemKey);
}

class _NutrientDetailsDetailState extends State<NutrientDetails> {
  _NutrientDetailsDetailState({this.itemKey});

  String itemKey;
  DocumentSnapshot documentSnapshot;

  bool _ready = false;

  FirebaseUser currentUser;
  var stream;

  /// Gathers the data needed to be displayed on this page before
  /// the page is 'ready'
  void doGathering() async {
    currentUser = await FirebaseAuth.instance.currentUser();

    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('ABBREV')
        .where('description', isEqualTo: itemKey).getDocuments();
    documentSnapshot = querySnapshot.documents[0];

    print("desc: " + documentSnapshot['description']);
    print("item: " + documentSnapshot['nutrients']['totalfat']['value'].toString());

    _ready = true;
    setState(() {});
  }

  @override
  void initState() {
    print("itemKey: " + itemKey.toString());
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
      ),
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
                                    documentSnapshot['nutrients']['totalfat']['value'] +
                                        documentSnapshot['nutrients']
                                            ['totalfat']['measurement'],
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            Text(
                              documentSnapshot['nutrients']['totalfat']
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

/// UI incomplete, details attempts to show nutrition details of some FoodItem
/// as a Dialog
class NutrientDetailsDocument extends StatefulWidget {
  @override
  _NutrientDetailsDocumentState createState() =>
      new _NutrientDetailsDocumentState();
}

class _NutrientDetailsDocumentState extends State<NutrientDetailsDocument> {
  Map<String, dynamic> documentSnapshot;

  bool _ready = false;
  var stream;

  void doGathering() async {
    _ready = true;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    doGathering();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Your Item',
          style: Theme.of(context).accentTextTheme.title,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
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
                                Text(documentSnapshot['nutrients']['calories']['value'],
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            /// TODO THIS
                            Text('Calories from Fat '),
                            Text(documentSnapshot['nutrients']['saturated']['value'])
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
                                    documentSnapshot['nutrients']['totalfat']
                                            ['value'] +
                                        documentSnapshot['nutrients']
                                            ['totalfat']['measurement'],
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                    ))
                              ],
                            ),
                            Text(
                              documentSnapshot['nutrients']['totalfat']
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
