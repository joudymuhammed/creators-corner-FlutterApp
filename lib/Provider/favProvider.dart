import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  List<Map<String, dynamic>> _favoriteProducts = [];

  List<Map<String, dynamic>> get favoriteProducts => _favoriteProducts;

  void addFavorite(Map<String, dynamic> product) {
    _favoriteProducts.add(product);
    notifyListeners();
  }

  void removeFavorite(Map<String, dynamic> product) {
    _favoriteProducts.remove(product);
    notifyListeners();
  }
}