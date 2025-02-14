import '../Models/ProductsModel.dart';

class CartItem {
  final Product product;
  int quantity;
  final String size;
  final String image;

  CartItem({required this.product,required this.image, required this.quantity, required this.size});
}
