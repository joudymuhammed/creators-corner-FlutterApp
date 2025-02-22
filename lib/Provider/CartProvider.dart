import 'package:flutter/material.dart';
import '../Component/CartItem.dart';
import '../Models/ProductsModel.dart';
import '../Services/MyCartService.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  final CartService cartService;

  CartProvider(this.cartService);

  List<CartItem> get cartItems => _cartItems;

  Future<void> fetchCartItems(int customerId) async {
    List<Product> products = await cartService.fetchCartItems(customerId);

    _cartItems.clear(); // Clear old items

    for (Product product in products) {
      _cartItems.add(CartItem(
        product: product,
        quantity: 1, // Default quantity 1 (you can modify this)
        size: "M", // Default size (modify if needed)
        image: product.image,
      ));
    }

    notifyListeners();
  }

  void addToCart({required Product product, required int quantity, required String size}) {
    final existingItemIndex = _cartItems.indexWhere((item) => item.product.id == product.id && item.size == size);

    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(
        product: product,
        quantity: quantity,
        size: size,
        image: product.image,
      ));
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

  double getTotalPrice() {
    return _cartItems.fold(0, (total, item) => total + (item.product.price * item.quantity));
  }
}
