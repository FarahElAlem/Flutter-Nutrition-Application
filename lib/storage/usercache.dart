class UserCache {
  Map<String, dynamic> favoriteNutrients = new Map<String, dynamic>();
  Map<String, dynamic> favoriteRecipes = new Map<String, dynamic>();

  void addToFavoriteNutrients(Map<String, dynamic> item) {
    favoriteNutrients[item['description']] = item;
  }

  void addToFavoriteRecipes(Map<String, dynamic> item) {
    favoriteRecipes[item['name']] = item;
  }

  void addAllToFavoriteNutrients(List<Map<String, dynamic>> item) {
    for (int i = 0; i < item.length; i++) {
      favoriteNutrients[item[i]['description']] = item[i];
    }
  }

  void addAllToFavoriteRecipes(List<Map<String, dynamic>> item) {
    for (int i = 0; i < item.length; i++) {
      favoriteRecipes[item[i]['name']] = item[i];
    }
  }

  void removeFromFavoriteNutrients(String key) {
    favoriteNutrients[key] = null;
  }

  void removeFromFavoriteRecipes(String key) {
    favoriteRecipes[key] = null;
  }

  bool isInFavoriteNutrients(String key) {
    return favoriteNutrients.keys.contains(key) == null;
  }

  bool isInFavoriteRecipes(String key) {
    return favoriteRecipes.keys.contains(key) == null;
  }

  Map<String, dynamic> getFavoriteNutrients() {
    return favoriteNutrients;
  }

  Map<String, dynamic> getFavoriteRecipes() {
    return favoriteRecipes;
  }
}
