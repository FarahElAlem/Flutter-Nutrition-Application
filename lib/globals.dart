import 'package:flutter/material.dart';

TextStyle headingTextStyle =
    new TextStyle(fontFamily: 'Montserrat', fontSize: 24.0);

TextStyle subHeadingTextStyle =
    new TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

TextStyle mainContentTextStyle =
    new TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);

TextStyle iconTextStyle = new TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
);

TextStyle detailsTextStyle =
    new TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

Widget getHeadingText(String text, [TextAlign textAlign = TextAlign.start]) {
  return Text(
    text,
    style: headingTextStyle,
    textAlign: textAlign,
  );
}

Widget getSubHeadingText(String text, [TextAlign textAlign = TextAlign.start]) {
  return Text(
    text,
    style: subHeadingTextStyle,
    textAlign: textAlign,
  );
}

Widget getMainContentText(String text,
    [TextAlign textAlign = TextAlign.start]) {
  return Text(
    text,
    style: mainContentTextStyle,
    textAlign: textAlign,
  );
}

Widget getIconText(String text) {
  return Text(text, style: iconTextStyle);
}

Widget getDetailsText(String text, [TextAlign textAlign = TextAlign.start]) {
  return Text(text, style: detailsTextStyle);
}