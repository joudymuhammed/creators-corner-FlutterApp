import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/CartProvider.dart';
import '../Component/Item.dart';
import '../Screens/CheckOut.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            "Images/Super_Stars-removebg.png",
            width: 160,
            height: 140,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      color: Colors.white.withOpacity(0.9),
                      offset: Offset(3, 1),
                      spreadRadius: 3,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "My Cart",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          return cartProvider.cartItems.isEmpty
                              ? const Center(
                            child: Text(
                              "Your cart is empty!",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                              : ListView.builder(
                            itemCount: cartProvider.cartItems.length,
                            itemBuilder: (context, index) {
                              final cartItem = cartProvider.cartItems[index];

                              return Column(
                                children: [
                                  Item(
                                    cartItem: cartItem,
                                    onRemove: () {
                                      cartProvider.removeFromCart(index);
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor: const Color(0xffFF5454),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CheckOutScreen()),
                        );
                      },
                      child: const Text(
                        "CHECKOUT ALL",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
