import 'package:flutter/material.dart';
import 'package:nutrition_app_flutter/globals.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: new Container(
            width: SCREENWIDTH * 0.9,
            child: new Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 18.0),
              child: new MaterialButton(
                onPressed: (){},
                color: Colors.lightGreen,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)
                ),
                child: new Text(
                  'Register',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
