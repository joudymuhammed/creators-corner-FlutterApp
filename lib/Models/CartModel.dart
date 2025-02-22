class AddToCartRequest {
  final String productId;

  AddToCartRequest({
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
    };
  }
}