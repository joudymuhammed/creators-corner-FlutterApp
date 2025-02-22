import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  Future<void> checkoutOrder(int customerId) async {
    try {
      final response = await _dio.post(
        'https://creatorscorner.runasp.net/api/Customer/checkout',
        queryParameters: {'customerId': customerId},
      );

      if (response.statusCode == 200) {
        print("✅ Order placed successfully!");
      } else {
        print("❌ Failed to place order: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error during checkout: $e");
    }
  }
}
