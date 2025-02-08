import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Component/bottom.dart';
import 'AccountScreens/Favourits.dart';
import 'ProductsDetails.dart';
import '../Provider/favProvider.dart'; // Import the provider

class HomeScreen extends StatefulWidget {
  final String? selectedBrand;
  final int? selectedBrandIndex;

  const HomeScreen({Key? key, this.selectedBrand, this.selectedBrandIndex}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBrandIndex = 0;

  final List<String> images = [
    'Images/Screenshot 2024-09-24 124055.png',
    'Images/Screenshot 2024-09-24 125503.png',
    'Images/460355975_1044180807194026_2928826092189388217_n.jpg',
    'Images/Picsart_24-10-12_15-59-45-546.png',
    'Images/Picsart_24-10-12_16-05-14-369.png'
  ];

  final List<List<Map<String, dynamic>>> brands = [
    // Brand 0
    [
      {
        'brand':'TWENTY SEVEN',
        'name': 'Pink Puff Tee',
        'price': 'LE 450.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 124602.png',
        'isLeft': true,
      },
      {
        'brand':'TWENTY SEVEN',
        'name': 'Persona Tee',
        'price': 'LE 395.00 EGP',
        'imagePath': 'Images/Screenshot 2024-04-30 191728.png',
        'isLeft': false,
      },
      {
        'brand':'TWENTY SEVEN',
        'name': 'Forward Forever Tee',
        'price': 'LE 400.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 140904.png',
        'isLeft': true,
      },
      {
        'brand':'TWENTY SEVEN',
        'name': 'Pink Short',
        'price': 'LE 400.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 124948.png',
        'isLeft': false,
      },

    ],
    // Brand 1
    [
      {
        'brand':'Gray',
        'name': 'SG Pink',
        'price': 'LE 1,350.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 125538.png',
        'isLeft': true,
      },
      {
        'brand':'Gray',
        'name': 'Black G Tee',
        'price': 'LE 350.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 125638.png',
        'isLeft': false,
      },
      {
        'brand':'Gray ',
        'name': 'Black jort',
        'price': 'LE 700.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 125727.png',
        'isLeft': true,
      },
    ],
    // Brand 2
    [
      {
        'brand':'Vice',
        'name': 'SG Pink',
        'price': 'LE 450.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 125307.png',
        'isLeft': true,
      },
      {
        'brand':'Vice',
        'name': 'Vice Angel Tee Blue & White',
        'price': 'LE 450.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 125114.png',
        'isLeft': false,
      },
      {
        'brand':'Vice',
        'name': 'Vice Cap نرجسي',
        'price': 'LE 300.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 124509.png',
        'isLeft': true,
      },
    ],
    // Brand 3
    [
      {
        'brand':'Decked Out',
        'name': 'Knite Shirt in black',
        'price': 'LE 1,350.00 EGP',
        'imagePath': 'Images/Screenshot 2024-10-12 180625.png',
        'isLeft': true,
      },
      {
        'brand':'Decked Out',
        'name': 'Knite shirt in green ',
        'price': 'LE 350.00 EGP',
        'imagePath': 'Images/Screenshot 2024-04-30 191728.png',
        'isLeft': false,
      },
      {
        'brand':'Decked Out',
        'name': 'DO Knite Shirt',
        'price': 'LE 700.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 140904.png',
        'isLeft': true,
      },
    ],
    // Brand 4
    [
      {
        'brand':'Laqta',
        'name': 'Black last shot T-shirt',
        'price': 'LE 450.00 EGP',
        'imagePath': 'Images/Capturesdsd.PNG',
        'isLeft': true,
      },
      {
        'brand':'Laqta',
        'name': '',
        'price': 'LE 700.00 EGP',
        'imagePath': 'Images/Screenshot 2024-04-30 191728.png',
        'isLeft': false,
      },
      {
        'brand':'Laqta',
        'name': 'White laqta shirt',
        'price': 'LE 350.00 EGP',
        'imagePath': 'Images/Screenshot 2024-09-24 140904.png',
        'isLeft': true,
      },
    ],
  ];

  @override
  void initState() {
    super.initState();
    if (widget.selectedBrandIndex != null) {
      selectedBrandIndex = widget.selectedBrandIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context); // Access the provider

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
            _buildBrandSelector(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var product in brands[selectedBrandIndex])
                      _buildProductRow(product, favoritesProvider),
                    Bottom() // Your bottom widget
                  ],
                ),
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

  Widget _buildBrandSelector() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedBrandIndex = index;
                });
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(images[index]),
                radius: 40,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductRow(Map<String, dynamic> product, FavoritesProvider favoritesProvider) {
    bool isFavorite = favoritesProvider.favoriteProducts.contains(product);

    return Row(
      mainAxisAlignment: product['isLeft'] ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (product['isLeft']) ...[
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

  Widget _buildProductContainer(Map<String, dynamic> product, FavoritesProvider favoritesProvider) {
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
            Image.asset(product['imagePath'], height: 125, width: 120, fit: BoxFit.cover),
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

  Widget _buildProductDetails(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(product['price'], style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}