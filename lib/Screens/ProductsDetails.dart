import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../Models/ProductsModel.dart';
import '../Provider/CartProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/MyCartService.dart';

class ProductsDetails extends StatefulWidget {
  final Product product;

  const ProductsDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  int quantity = 1;
  String? selectedSize;
  bool isAddingToCart = false;

  Future<String?> getCustomerId() async {
    final preferences = await SharedPreferences.getInstance();
    int? customerId = preferences.getInt('customerId');
    return customerId?.toString();
  }



  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartService = CartService(Dio());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.product.image, height: 400, width: double.infinity, fit: BoxFit.cover),
              const SizedBox(height: 15),
              Text(widget.product.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(
                '${widget.product.price} LE',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Size selection
              const Text('Size', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: ['XXS', 'XS', 'S', 'M', 'L', 'XL']
                    .map((size) => ChoiceChip(
                    label: Text(size, style: const TextStyle(fontSize: 17)),
                    selected: selectedSize == size,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedSize = selected ? size : null;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Colors.black,
                    labelStyle: TextStyle(
                      color: selectedSize == size ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ))).toList(),
              ),
              const SizedBox(height: 20),

              // Quantity selection
              const Text('Quantity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Text("$quantity", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outlined),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Add to Cart Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                  onPressed: isAddingToCart ? null : () async {
                    if (selectedSize == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a size."), backgroundColor: Colors.red),
                      );
                      return;
                    }

                    String? customerId = await getCustomerId();
                    if (customerId == null || customerId.isEmpty) {
                      print("❌ User not logged in");
                      return;
                    }

                    setState(() {
                      isAddingToCart = true;
                    });

                    try {
                      await cartService.addItemToCart(customerId, widget.product.id.toString());

                      cartProvider.addToCart(
                        product: widget.product,
                        quantity: quantity,
                        size: selectedSize!,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added to cart."), backgroundColor: Colors.green),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to add to cart"), backgroundColor: Colors.red),
                      );
                    } finally {
                      setState(() {
                        isAddingToCart = false;
                      });
                    }
                  },

                  child: const Text('Add to cart', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}