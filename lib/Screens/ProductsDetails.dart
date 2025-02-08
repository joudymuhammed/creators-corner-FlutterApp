  import 'package:creators_corner/Provider/CartProvider.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart'; // Import provider

  class Productsdetails extends StatefulWidget {
    final Map<String, dynamic> product;

    const Productsdetails({Key? key, required this.product}) : super(key: key);

    @override
    State<Productsdetails> createState() => _ProductsdetailsState();
  }

  class _ProductsdetailsState extends State<Productsdetails> {
    int quantity = 0;
    String? selectedSize;
    bool isAddToCartSelected = false;
    bool isBuyNowSelected = false;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.product['brand'],
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
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(widget.product['imagePath']),
                  SizedBox(height: 15),
                  Text(widget.product['brand'], style: TextStyle(fontSize: 20)),
                  Text(
                    widget.product['name'],
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  Row(
                    children: [
                      Text(
                        'LE 700.00',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        widget.product['price']?.toString() ?? 'Price not available',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Sale',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Size',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: ['xxs', 'xs', 's', 'm', 'l', 'xl']
                        .map((size) => ChoiceChip(
                      label: Text(size, style: TextStyle(fontSize: 17)),
                      selected: selectedSize == size,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedSize = selected ? size : null;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: Colors.grey[800],
                      labelStyle: TextStyle(
                        color: selectedSize == size
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                        .toList(),
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Quantity',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          setState(() {
                            if (quantity > 0) quantity--;
                          });
                        },
                      ),
                      Text(
                        "$quantity",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outlined),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (selectedSize == null || quantity == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please select size and quantity."),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            context.read<CartProvider>().addToCart({
                              'product': widget.product,
                              'quantity': quantity,
                              'size': selectedSize,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Added to cart."),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          isAddToCartSelected ? Colors.black : Colors.white,
                          side: BorderSide(color: Colors.black),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                            color: isAddToCartSelected
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Text(
                    '. 100% COTTON\n. 270 GSM\nHIGH QUALITY SCREEN PRINTING',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
