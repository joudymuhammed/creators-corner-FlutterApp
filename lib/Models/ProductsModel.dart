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
      id: json['id'] ?? 0,  // Default to 0 if null
      name: json['name'] ?? 'Unknown',  // Default name
      description: json['description'] ?? 'No description',
      price: json['price'] ?? 0.0, // Default to 0 if null
      image: json['imageUrl'] ?? '', // Avoid null errors in Image.network
      stockQuantity: json['stockQuantity'] ?? 0,
      brandId: json['brandId'] ?? 0,
    );
  }
}
