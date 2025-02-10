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
        title: Text(widget.selectedBrand ?? 'Brands'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Image.asset("Images/Super_Stars-removebg.png", height: 134, width: 190),
            _buildSearchBar(),
            const SizedBox(height: 10),
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
                          _buildProductRow(products[i], i, favoritesProvider), // Correct order
                        Bottom(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search Products',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildProductRow(Product product, int index, FavoritesProvider favoritesProvider) {
    bool isLeft = index % 2 == 0; // Alternate left-right layout

    return Row(
      mainAxisAlignment: isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (isLeft) ...[
          _buildProductContainer(product, favoritesProvider),
          const SizedBox(width: 10),
          _buildProductDetails(product),
        ] else ...[
          _buildProductDetails(product),
          const SizedBox(width: 10),
          _buildProductContainer(product, favoritesProvider),
        ],
      ],
    );
  }

  Widget _buildProductContainer(Product product, FavoritesProvider favoritesProvider) {
    bool isFavorite = favoritesProvider.favoriteProducts.contains(product);

    return Container(
      height: 180,
      width: 150,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Productsdetails(product: product)),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           // Image.network(product.imagePath, height: 125, width: 120, fit: BoxFit.cover),

            Image.asset('Images/Screenshot 2024-04-30 191728.png', height: 125, width: 120, fit: BoxFit.cover),
            const SizedBox(height: 5),
            IconButton(
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    favoritesProvider.removeFavorite(product);
                  } else {
                    favoritesProvider.addFavorite(product);
                  }
                });
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
              ),
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
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
        Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('${product.price.toStringAsFixed(2)} EGP'), // Ensure it's displayed correctly
      ],
    );
  }
}
