import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrition_app_flutter/pages/recipe/utilities/materialsearch.dart';

class RecipeCreate extends StatefulWidget {
  RecipeCreate({this.searchKeys});

  final List<TextEditingController> ingredientControllerList = new List();
  final List<TextEditingController> directionControllerList = new List();

  final List<String> ingredientNames = new List();

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();

  final int index = 0;

  final List<dynamic> searchKeys;

  @override
  State<StatefulWidget> createState() {
    return new _RecipeCreateState(
        ingredientControllerList: ingredientControllerList,
        directionControllerList: directionControllerList,
        ingredientNames: ingredientNames,
        index: index);
  }
}

class _RecipeCreateState extends State<RecipeCreate>
    with SingleTickerProviderStateMixin {
  _RecipeCreateState({this.ingredientControllerList,
    this.directionControllerList,
    this.ingredientNames,
    this.index});

  List<TextEditingController> ingredientControllerList;
  List<TextEditingController> directionControllerList;

  List<String> ingredientNames;

  TabController _tabController;
  int _currentIndex = 0;

  int index;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Widget _buildNamingPage(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Lets Name\nThat Recipe!',
                  style: Theme
                      .of(context)
                      .accentTextTheme
                      .headline,
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: Colors.transparent,
                ),

                /// TODO Add picture here
                InkWell(
                  onTap: getImage,
                  child: Center(
                    child: Container(
                        width: 190.0,
                        height: 190.0,
                        child: _image == null
                            ? Text(
                          'No image selected.',
                          textAlign: TextAlign.center,
                        )
                            : Image.file(_image),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                        )),
                  ),
                ),
                TextField(
                  controller: widget._nameController,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: Theme
                          .of(context)
                          .accentTextTheme
                          .body1),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextField(
                  controller: widget._descriptionController,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: Theme
                          .of(context)
                          .accentTextTheme
                          .body1),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.keyboard_arrow_right),
        )
      ],
    );
  }

  Widget _buildIngredientsPage(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Lets Gather\nThe Ingredients!',
                  style: Theme
                      .of(context)
                      .accentTextTheme
                      .headline,
                  textAlign: TextAlign.center,
                ),
                Divider(color: Colors.transparent),
                Row(
                  children: <Widget>[
                    Text(
                      'Ingredients',
                      style: Theme
                          .of(context)
                          .accentTextTheme
                          .subhead,
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () async {
                        String selected = await showSearch(context: context,
                            delegate: MaterialSearch(items: widget.searchKeys, type: 'create'));
                        if (selected != null) {
                          ingredientNames.add(selected);
                          ingredientControllerList.add(
                              new TextEditingController());
                          setState(() {});
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        ingredientControllerList.removeLast();
                        setState(() {});
                      },
                    )
                  ],
                ),
                (ingredientControllerList.length != 0) ? Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: ingredientControllerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                NumericComboBox(),
                                Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 8.0)),
                                ServingComboBox()
                              ],
                            ),
                            title: Text(ingredientNames[index], style: Theme.of(context).accentTextTheme.title,)
                        );
                      }),
                ) : Container(child: Text('Add Some Ingredients!', style: Theme
                    .of(context)
                    .accentTextTheme
                    .title, textAlign: TextAlign.center,))
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.keyboard_arrow_right),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.keyboard_arrow_left),
        )
      ],
    );
  }

  Widget _buildDirectionsPage(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'Lets Build\nThe Directions!',
                  style: Theme
                      .of(context)
                      .accentTextTheme
                      .headline,
                  textAlign: TextAlign.center,
                ),
                Divider(color: Colors.transparent),
                Row(
                  children: <Widget>[
                    Text(
                      'Directions',
                      style: Theme
                          .of(context)
                          .accentTextTheme
                          .subhead,
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        directionControllerList
                            .add(new TextEditingController());
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        directionControllerList.removeLast();
                        setState(() {});
                      },
                    )
                  ],
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: directionControllerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 0.0,
                          child: ListTile(
                            leading: Text(
                              (index + 1).toString(),
                              style: Theme
                                  .of(context)
                                  .accentTextTheme
                                  .title,
                            ),
                            title: TextFormField(
                                controller: directionControllerList[index],
                                style: Theme
                                    .of(context)
                                    .accentTextTheme
                                    .title,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Enter direction..',
                                )),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.keyboard_arrow_left),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (mounted) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Recipe'),
        centerTitle: true,
      ),
      body: TabBarView(
        children: [
          _buildNamingPage(context),
          _buildIngredientsPage(context),
          _buildDirectionsPage(context)
        ],
        controller: _tabController,
      ),
      floatingActionButton: (_currentIndex == 2)
          ? FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.done),
      )
          : null,
    );
  }
}

class NumericComboBox extends StatefulWidget {
  _NumericComboBoxState createState() => new _NumericComboBoxState();
}

class _NumericComboBoxState extends State<NumericComboBox> {
  String _currentIndex = '1';

  Widget _buildNumericComboBox() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(new DropdownMenuItem(
        value: '1/4',
        child: Text(
          '1/4',
          style: Theme
              .of(context)
              .accentTextTheme
              .body1,
        )));
    items.add(new DropdownMenuItem(
        value: '1/3',
        child: Text(
          '1/3',
          style: Theme
              .of(context)
              .accentTextTheme
              .body1,
        )));
    items.add(new DropdownMenuItem(
        value: '1/2',
        child: Text(
          '1/2',
          style: Theme
              .of(context)
              .accentTextTheme
              .body1,
        )));
    items.add(new DropdownMenuItem(
        value: '3/4',
        child: Text(
          '3/4',
          style: Theme
              .of(context)
              .accentTextTheme
              .body1,
        )));
    for (int i = 1; i < 8; i++) {
      items.add(new DropdownMenuItem(
          value: i.toString(),
          child: Text(
            i.toString(),
            style: Theme
                .of(context)
                .accentTextTheme
                .body1,
          )));
    }

    return DropdownButton(
      elevation: 0,
      isDense: true,
      value: _currentIndex,
      items: items,
      onChanged: (String key) {
        setState(() {
          _currentIndex = key;
        });
      },
    );
  }

  void changedDropDownItem(String number) {
    _currentIndex = number;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _buildNumericComboBox();
  }
}

class ServingComboBox extends StatefulWidget {
  _ServingComboBoxState createState() => new _ServingComboBoxState();
}

class _ServingComboBoxState extends State<ServingComboBox> {
  String _currentIndex = 'item of';

  List<String> servings = ['item of', 'tbs.', 'tsp.', 'lb.', 'oz.', 'cup(s)'];

  Widget _buildServingComboBox() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < servings.length; i++) {
      items.add(new DropdownMenuItem(
          value: servings[i],
          child: Text(
            servings[i],
            style: Theme
                .of(context)
                .accentTextTheme
                .body1,
          )));
    }

    return DropdownButton(
      elevation: 0,
      value: _currentIndex,
      items: items,
      onChanged: (String key) {
        setState(() {
          _currentIndex = key;
        });
      },
    );
  }

  void changedDropDownItem(String number) {
    _currentIndex = number;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _buildServingComboBox();
  }
}
