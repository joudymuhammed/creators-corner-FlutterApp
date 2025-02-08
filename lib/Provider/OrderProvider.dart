import 'package:flutter/material.dart';

import '../Models/OrderModel.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}