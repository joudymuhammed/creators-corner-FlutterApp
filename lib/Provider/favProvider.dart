import 'package:flutter/material.dart';
import '../Models/ProductsModel.dart';

class FavoritesProvider with ChangeNotifier {
  List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => _favoriteProducts;

  void addFavorite(Product product) {
    _favoriteProducts.add(product);
    notifyListeners();
  }

  void removeFavorite(Product product) {
    _favoriteProducts.removeWhere((fav) => fav.id == product.id);
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favoriteProducts.any((fav) => fav.id == product.id);
  }
}
