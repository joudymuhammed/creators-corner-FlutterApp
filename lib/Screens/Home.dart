import 'dart:convert';
import 'dart:typed_data'; // ✅ Correct Import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Component/bottom.dart';
import '../Provider/favProvider.dart';
import '../Models/ProductsModel.dart';
import '../Services/ProductsService.dart';
import 'ProductsDetails.dart';

class HomeScreen extends StatefulWidget {
  final String? selectedBrand;
  final int? selectedBrandIndex;

  const HomeScreen({Key? key, this.selectedBrand, this.selectedBrandIndex}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD6D6D6),
        title: Text(widget.selectedBrand ?? 'Brands', style: TextStyle(color: Colors.black)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Image.asset("Images/Super_Stars-removebg.png", height: 100),
          _buildSearchBar(),
          const SizedBox(height: 10),
          _buildBrandRow(),
          const SizedBox(height: 15),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No products available"));
                }

                List<Product> products = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < products.length; i++)
                        _buildProductRow(products[i], i, favoritesProvider),
                      Bottom(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search Products',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildBrandRow() {
    List<String> brandLogos = [
      "Images/460355975_1044180807194026_2928826092189388217_n.jpg",
      "Images/Picsart_24-10-12_16-05-14-369.png",
      "Images/Picsart_24-10-12_15-59-45-546.png",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: brandLogos.map((logo) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: logo.contains("brand2") ? 2 : 0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(logo),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductRow(Product product, int index, FavoritesProvider favoritesProvider) {
    bool isLeft = index % 2 == 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isLeft) ...[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsDetails(product: product),
                  ),
                );
              },
              child: _buildProductContainer(product, favoritesProvider),
            ),
            const SizedBox(width: 10),
            _buildProductDetails(product),
          ] else ...[
            _buildProductDetails(product),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsDetails(product: product),
                  ),
                );
              },
              child: _buildProductContainer(product, favoritesProvider),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProductContainer(Product product, FavoritesProvider favoritesProvider) {
    bool isFavorite = favoritesProvider.favoriteProducts.contains(product);

    print("Product Image Data: ${product.image}"); // Debugging: Check API response

    Uint8List? imageBytes;
    if (product.image.isNotEmpty) {
      try {
        imageBytes = base64Decode(product.image); // Decode Base64
      } catch (e) {
        print("Error decoding image: $e");
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 150,
        height: 200,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            imageBytes != null
                ? Image.memory(imageBytes, width: double.infinity, height: 180, fit: BoxFit.cover)
                : Image.asset('assets/images/placeholder.png', width: double.infinity, height: 180, fit: BoxFit.cover),
            Positioned(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite
                        ? favoritesProvider.removeFavorite(product)
                        : favoritesProvider.addFavorite(product);
                  });
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetails(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "LE ${product.price.toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.black, fontSize: 12),
        ),
      ],
    );
  }
}
