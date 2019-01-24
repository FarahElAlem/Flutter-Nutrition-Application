import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrition_app_flutter/structures/fooditem.dart';

Firestore fdb;
List<List<String>> FOODGROUPNAMES = [];
double SCREENWIDTH = 0.0;
double SCREENHEIGHT = 0.0;

List<FoodItem> SAVEDNUTRIENTS = [];
var SAVEDRECIPES;