import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/OrderProvider.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: ordersProvider.orders.isEmpty
          ? const Center(child: Text("No orders found."))
          : ListView.builder(
            itemCount: ordersProvider.orders.length,
            itemBuilder: (context, index) {
          final order = ordersProvider.orders[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: ListTile(
              title: Text(order.productName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order ID: ${order.orderId}"),
                  Text("Price: ${order.price}"),
                  Text("Status: ${order.status}"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  // Navigate to order details page if needed
                },
              ),
            ),
          );
        },
      ),
    );
  }
}