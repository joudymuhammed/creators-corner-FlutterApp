import 'package:flutter/material.dart';
import '../Component/CartItem.dart';
import '../Models/ProductsModel.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart({required Product product, required int quantity, required String size}) {
    _cartItems.add(CartItem(
      product: product,
      quantity: quantity,
      size: size,
      image: product.image,
    ));
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
