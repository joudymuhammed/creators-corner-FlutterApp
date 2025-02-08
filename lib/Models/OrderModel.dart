// order_model.dart
class Order {
  final String orderId;
  final String productName;
  final String price;
  final String status;

  Order({
    required this.orderId,
    required this.productName,
    required this.price,
    required this.status,
  });
}