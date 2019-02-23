import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


/// TODO Do after DB Update to 300k items
class NutrientItem {
  Map<String, dynamic> documentData = new Map();

  NutrientItem(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data;
    documentData['ndbno'] = data['ndb'];
    documentData['name'] = data['description'];
    documentData['manufacturer'] = data['manufacturer'];
    documentData['ingredients'] = data['ingredients'];
    documentData['nutrients'] = data['nutrients'];
    documentData['serving_size'] = data['serving_size'];
    documentData['serving_measurement'] = data['serving_measurement'];
  }
}
