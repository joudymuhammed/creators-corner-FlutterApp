import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/OrderProvider.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(child: Text("oops you dont have orders")),
        ],
      ),
    );
  }
}