import 'package:creators_corner/Screens/CheckOut.dart';
import 'package:creators_corner/Screens/EditCart.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final Map<String, dynamic> product;
  final int quantity;
  final VoidCallback onRemove;

  const Item({
    Key? key,
    required this.product,
    required this.quantity,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffF0F0F0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        height: 150,
        width: double.infinity,
        child: Column(
          children: [

            Expanded(

                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(product['imagePath']),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['brand'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              product['price'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Quantity: $quantity",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onRemove,
                    ),
                  ],
                ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFFC3C3),
                    ),
                    child: const Text("Edit", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCart(
                            name: product['name'],
                            image: product['imagePath'],
                            price: product['price'],
                            brand: product['brand'],
                            quantity: quantity,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF5454),
                    ),
                    child: const Text("Checkout", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutScreen(),));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}