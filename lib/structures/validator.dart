import 'package:cloud_firestore/cloud_firestore.dart';

class Validator {
  bool _isNumeric(String s) {
    for (int i = 0; i < s.length; i++) {
      if (double.tryParse(s[i]) != null) {
        return true;
      }
    }
    return false;
  }

  String validateEmail(String s) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(s)) {
      return 'Please enter an email! (We wont spam you, promise!)';
    } else {
      return null;
    }
  }

  String validateName(String s) {
    if (_isNumeric(s)) {
      return 'Your name has characters in it? That is awesome dude!';
    }
    if (s.isEmpty) {
      return 'Please enter your name! We just want to get to know you!';
    }
    return null;
  }

  String validatePassword(String s) {
    if (s.isEmpty) {
      return 'Please enter a password!';
    }
    return null;
  }

  Future<String> validateLoggedInUser(String email, String password) async {
    var query = await Firestore.instance
        .collection('USERS')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .getDocuments();
    if (query.documents.length == 0) {
      return 'We dont have any accounts with those credentials!';
    }
    return null;
  }
}
