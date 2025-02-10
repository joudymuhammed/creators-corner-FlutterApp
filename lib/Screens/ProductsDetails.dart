import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/ProductsModel.dart';
import '../Provider/CartProvider.dart';
import '../Models/CartItem.dart';

class Productsdetails extends StatefulWidget {
  final Product product;

  const Productsdetails({Key? key, required this.product}) : super(key: key);

  @override
  State<Productsdetails> createState() => _ProductsdetailsState();
}

class _ProductsdetailsState extends State<Productsdetails> {
  int quantity = 1;
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
              Image.asset('Images/Screenshot 2024-04-30 191728.png', height: 400, width: double.infinity, fit: BoxFit.cover),
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
                  selectedColor: Colors.grey[800],
                  labelStyle: TextStyle(
                    color: selectedSize == size ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ))
                    .toList(),
              ),
              const SizedBox(height: 20),

              // Quantity selection
              const Text('Quantity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                onPressed: () {
                  if (selectedSize == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a size."),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final cartProvider = context.read<CartProvider>();
                  cartProvider.addToCart(widget.product, selectedSize!);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Added to cart."),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Add to cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Product description
              const Text(
                '• 100% Cotton\n• 270 GSM\n• High-quality screen printing',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
