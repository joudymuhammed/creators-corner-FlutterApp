import 'package:flutter/material.dart';
import '../ProductsDetails.dart';

class FavouritesPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteProducts;

  const FavouritesPage({Key? key, required this.favoriteProducts}) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late List<Map<String, dynamic>> favoriteProducts;

  @override
  void initState() {
    super.initState();
    favoriteProducts = widget.favoriteProducts;
  }

  void deleteProduct(int index) {
    setState(() {
      favoriteProducts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text("No favorite products yet."))
          : ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          var product = favoriteProducts[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: Image.asset(product['imagePath'], width: 50, height: 50, fit: BoxFit.cover),
              title: Text(product['name']),
              subtitle: Text(product['price']),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () => deleteProduct(index), // Deletes the product
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Productsdetails(product: product)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
