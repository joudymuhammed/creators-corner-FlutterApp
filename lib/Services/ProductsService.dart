// services/product_service.dart
import 'package:dio/dio.dart';

import '../Models/ProductsModel.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('http://creatorscorner.runasp.net/api/Customer/products');
      if (response.data['status']) {
        List<Product> products = (response.data['data'] as List)
            .map((product) => Product.fromJson(product))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}