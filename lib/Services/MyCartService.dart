import 'package:dio/dio.dart';

import '../Models/ProductsModel.dart';

class CartService {
  final Dio _dio;

  CartService(this._dio);

  Future<void> addItemToCart(String customerId, String productId) async {
    try {
      print("📤 Sending request to API...");
      print("🔹 customerId: $customerId");
      print("🔹 productId: $productId");

      final response = await _dio.post(
        'https://creatorscorner.runasp.net/api/Customer/add-to-cart',
        queryParameters: {
          'customerId': customerId,
          'productId': productId,
        },
      );

      print("📥 Response: ${response.data}");

      if (response.data['status']) {
        print("✅ Item added to cart successfully!");
      } else {
        print("❌ Failed to add item to cart: ${response.data['message']}");
      }
    } catch (e) {
      print("❌ Error adding item to cart: $e");
      throw Exception('Failed to add item to cart: $e');
    }
  }


  Future<List<Product>> fetchCartItems(int customerId) async {
    try {
      print("📤 Fetching cart items for customer ID: $customerId");

      final cartResponse = await _dio.get(
        'https://creatorscorner.runasp.net/api/Customer/cart',
        queryParameters: {'customerId': customerId},
      );

      print("✅ Cart API Response: ${cartResponse.data}");

      if (cartResponse.data['status']) {
        List<int> productIds = List<int>.from(cartResponse.data['data']['products']);

        final productResponse = await _dio.get(
          'https://creatorscorner.runasp.net/api/Customer/products',
        );

        print("✅ All Products API Response: ${productResponse.data}");

        if (productResponse.data['status']) {
          List<Product> allProducts = (productResponse.data['data'] as List)
              .map((json) => Product.fromJson(json))
              .toList();

          List<Product> cartProducts = allProducts.where((product) {
            return productIds.contains(product.id);
          }).toList();

          return cartProducts;
        } else {
          print("❌ Failed to fetch all products: ${productResponse.data['message']}");
          return [];
        }
      } else {
        print("❌ Failed to fetch cart items: ${cartResponse.data['message']}");
        return [];
      }
    } catch (e) {
      print("❌ Error fetching cart items: $e");
      return [];
    }
  }
}