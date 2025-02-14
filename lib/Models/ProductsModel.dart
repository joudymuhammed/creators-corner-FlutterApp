class Product {
  final int id;
  final String name;
  final String description;
   var price;
   final String image;
  final int stockQuantity;
  final int brandId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.stockQuantity,
    required this.brandId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['imageUrl'],
      stockQuantity: json['stockQuantity'],
      brandId: json['brandId'],
    );
  }
}
