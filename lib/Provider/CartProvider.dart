import 'package:flutter/material.dart';
import '../Models/ProductsModel.dart';
import '../Models/CartItem.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product, String size) {
    var existingItemIndex = _cartItems.indexWhere(
          (item) => item.product.id == product.id && item.size == size,
    );

    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity += 1;
    } else {
      _cartItems.add(CartItem(product: product, quantity: 1, size: size));
    }

    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
