import 'package:dio/dio.dart';

import '../Models/ProductsModel.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('http://creatorscorner.runasp.net/api/Customer/products');

      print(response.data);

      if (response.data['status']) {
        List<Product> products = (response.data['data'] as List)
            .map((product) => Product.fromJson(product))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products: ${response.data['message']}');
      }
    } catch (e) {
      print("Error fetching products: $e");
      throw Exception('Failed to load products: $e');
    }
  }
}