import 'package:creators_corner/Screens/CheckOut.dart';
import 'package:creators_corner/Screens/Home.dart';
import 'package:creators_corner/main.dart';
import 'package:flutter/material.dart';

class EditCart extends StatefulWidget {
  final String name;
  final String image;
  final String price;
  final String brand;
  final int quantity;

  const EditCart({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.brand,
    required this.quantity,
  }) : super(key: key);

  @override
  _EditCartState createState() => _EditCartState();
}

class _EditCartState extends State<EditCart> {
  late int currentQuantity;

  @override
  void initState() {
    super.initState();
    currentQuantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.brand} Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🛠️ FIX: Constrained the image size to prevent overflow
                SizedBox(
                  width: 80, // Adjusted width
                  height: 80, // Adjusted height
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover, // Keeps the image contained
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis, // Prevents text overflow
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (currentQuantity > 1) currentQuantity--;
                    });
                  },
                ),
                Text(
                  "$currentQuantity",
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      currentQuantity++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Ensures the row doesn't overflow
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xffFF5454)),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomBottomNavBar(),
                            ),
                          );
                        },
                        child: Text(
                          "Add items",
                          style: TextStyle(color: Color(0xffFF5454)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffFF5454),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckOutScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
