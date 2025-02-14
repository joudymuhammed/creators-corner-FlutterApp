import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/favProvider.dart';
import '../ProductsDetails.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: favoritesProvider.favoriteProducts.isEmpty
          ? const Center(child: Text("No favorite products yet."))
          : ListView.builder(
        itemCount: favoritesProvider.favoriteProducts.length,
        itemBuilder: (context, index) {
          var product = favoritesProvider.favoriteProducts[index];
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
              leading: Image.network(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/default_product.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  );
                },
              ),

              title: Text(product.name),
              subtitle: Text('${product.price} LE'),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  favoritesProvider.removeFavorite(product);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsDetails(product: product)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
