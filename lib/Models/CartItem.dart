import '../Models/ProductsModel.dart';

class CartItem {
  final Product product;
  int quantity;
  final String size;

  CartItem({required this.product, required this.quantity, required this.size});
}
