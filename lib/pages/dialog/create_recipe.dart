import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RecipeCreate extends StatefulWidget {
  List<TextEditingController> ingredientControllerList = new List();
  List<TextEditingController> directionControllerList = new List();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  int index = 0;

  @override
  State<StatefulWidget> createState() {
    ingredientControllerList.add(new TextEditingController());
    directionControllerList.add(new TextEditingController());
    return new _RecipeCreateState(
        ingredientControllerList: ingredientControllerList,
        directionControllerList: directionControllerList,
        index: index);
  }
}

class _RecipeCreateState extends State<RecipeCreate>
    with SingleTickerProviderStateMixin {
  _RecipeCreateState(
      {this.ingredientControllerList,
      this.directionControllerList,
      this.index});

  List<TextEditingController> ingredientControllerList;
  List<TextEditingController> directionControllerList;

  TabController _tabController;

  int index;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Widget _buildNamingPage(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Lets Name\nThat Recipe!',
              style: Theme.of(context).accentTextTheme.headline,
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
                  labelStyle: Theme.of(context).accentTextTheme.body1),
            ),
            Divider(
              color: Colors.transparent,
            ),
            TextField(
              controller: widget._descriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: Theme.of(context).accentTextTheme.body1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsPage(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Lets Gather\nThe Ingredients!',
              style: Theme.of(context).accentTextTheme.headline,
              textAlign: TextAlign.center,
            ),
            Divider(color: Colors.transparent),
            Row(
              children: <Widget>[
                Text(
                  'Ingredients',
                  style: Theme.of(context).accentTextTheme.subhead,
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    ingredientControllerList.add(new TextEditingController());
                    setState(() {});
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
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ingredientControllerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: NumericComboBox(),
                          title: TextFormField(
                            controller: ingredientControllerList[index],
                            style: Theme.of(context).accentTextTheme.title,
                            autocorrect: true,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Enter ingredient...',
                            ),
                          ),
                        ),
                        Divider(height: 2.0,)
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectionsPage(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              'Lets Build\nThe Directions!',
              style: Theme.of(context).accentTextTheme.headline,
              textAlign: TextAlign.center,
            ),
            Divider(color: Colors.transparent),
            Row(
              children: <Widget>[
                Text(
                  'Directions',
                  style: Theme.of(context).accentTextTheme.subhead,
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    directionControllerList.add(new TextEditingController());
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
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[ListTile(
                        leading: Text(
                          (index + 1).toString(),
                          style: Theme.of(context).accentTextTheme.body1,
                          textAlign: TextAlign.center,
                        ),
                        title: TextFormField(
                            controller: directionControllerList[index],
                            style: Theme.of(context).accentTextTheme.title,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Enter direction..',
                            )),
                      ),
                      Divider(height: 2.0,)],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Recipe'),
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.info),
            ),
            Tab(
              icon: Icon(Icons.list),
            ),
            Tab(
              icon: Icon(Icons.directions),
            )
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [
          _buildNamingPage(context),
          _buildIngredientsPage(context),
          _buildDirectionsPage(context)
        ],
        controller: _tabController,
      ),
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
    for (int i = 1; i < 16; i++) {
      items.add(new DropdownMenuItem(
          value: i.toString(),
          child: Text(
            i.toString(),
            style: Theme.of(context).accentTextTheme.caption,
          )));
    }

    return DropdownButton(
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
    // TODO: implement build
    return _buildNumericComboBox();
  }
}
