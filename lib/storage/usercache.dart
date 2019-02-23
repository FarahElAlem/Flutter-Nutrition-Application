import 'package:cloud_firestore/cloud_firestore.dart';

class UserCache {
  Map<String, dynamic> favoriteNutrients = new Map<String, dynamic>();
  Map<String, dynamic> favoriteRecipes = new Map<String, dynamic>();

  void addToFavoriteNutrients(Map<String, dynamic> item) {
    favoriteNutrients[item['description']] = item;
  }

  void addToFavoriteRecipes(Map<String, dynamic> item) {
    favoriteRecipes[item['name']] = item;
  }

  void addAllToFavoriteNutrients(List<DocumentSnapshot> item) {
    for (int i = 0; i < item.length; i++) {
      favoriteNutrients[item[i].data['description']] = item[i];
    }
  }

  void addAllToFavoriteRecipes(List<DocumentSnapshot> item) {
    for (int i = 0; i < item.length; i++) {
      favoriteRecipes[item[i].data['name']] = item[i];
    }
  }

  void removeFromFavoriteNutrients(String key) {
    favoriteNutrients.remove(key);
  }

  void removeFromFavoriteRecipes(String key) {
    favoriteRecipes.remove(key);
  }

  bool isInFavoriteNutrients(String key) {
    return favoriteNutrients.keys.contains(key);
  }

  bool isInFavoriteRecipes(String key) {
    return favoriteRecipes.keys.contains(key);
  }

  Map<String, dynamic> getFavoriteNutrients() {
    return favoriteNutrients;
  }

  Map<String, dynamic> getFavoriteRecipes() {
    return favoriteRecipes;
  }
}
