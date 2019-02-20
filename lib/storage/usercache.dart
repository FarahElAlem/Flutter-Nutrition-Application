
class UserCache {
  List<Map<String, dynamic>> favoriteNutrients = new List<Map<String, dynamic>>();
  List<Map<String, dynamic>> favoriteRecipes = new List<Map<String, dynamic>>();

  void addToFavoriteNutrients (Map<String, dynamic> item) {
    favoriteNutrients.add(item);
  }

  void addToFavoriteRecipes (Map<String, dynamic> item) {
    favoriteRecipes.add(item);
  }

  void addAllToFavoriteNutrients (List<Map<String, dynamic>> item) {
    favoriteNutrients.addAll(item);
  }

  void addAllToFavoriteRecipes (List<Map<String, dynamic>> item) {
    favoriteRecipes.addAll(item);
  }

  List<Map<String, dynamic>> getFavoriteNutrients() {
    return favoriteNutrients;
  }

  List<Map<String, dynamic>> getFavoriteRecipes() {
    return favoriteRecipes;
  }
}