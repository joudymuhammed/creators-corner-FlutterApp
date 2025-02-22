import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Component/Item.dart';
import '../Screens/CheckOut.dart';
import '../Provider/CartProvider.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCartItems();
    });
  }

  Future<void> _fetchCartItems() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final preferences = await SharedPreferences.getInstance();
    int? customerId = preferences.getInt("customerId");

    if (customerId != null) {
      await cartProvider.fetchCartItems(customerId);
    } else {
      print("❌ Error: No logged-in customer ID found!");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Image.asset("Images/Super_Stars-removebg.png",
              width: 160, height: 140, errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: cartItems.isEmpty
                  ? const Center(
                child: Text("Your cart is empty!", style: TextStyle(fontSize: 18)),
              )
                  : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  return Column(
                    children: [
                      Item(
                        cartItem: cartItem,
                        onRemove: () => cartProvider.removeFromCart(index),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                backgroundColor: const Color(0xffFF5454),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: cartItems.isEmpty
                  ? null
                  : () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => CheckOutScreen()));
              },
              child: const Text("CHECKOUT ALL", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
