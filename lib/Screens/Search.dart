import 'package:flutter/material.dart';

import '../Component/HomeScreenWrapper.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, String>> brandList = [
    {
      "name": "TWENTY SEVEN",
      "image": "Images/Screenshot 2024-09-24 124055.png",
    },
    {
      "name": "Gray",
      "image": "Images/Screenshot 2024-09-24 125503.png",
    },
    {
      "name": "91 Tee",
      "image": "Images/460355975_1044180807194026_2928826092189388217_n.jpg",
    },
    {
      "name": "Decked Out",
      "image": "Images/Picsart_24-10-12_15-59-45-546.png",
    },
    {
      "name": "Laqta",
      "image": "Images/Picsart_24-10-12_16-05-14-369.png",
    },
  ];

  List<Map<String, String>> filteredBrands = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    filteredBrands = []; // Initialize with an empty list
  }

  void _filterBrands(String query) {
    final filtered = brandList.where((brand) {
      return brand['name']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      this.query = query;
      filteredBrands = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Local Brands'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search Field
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                onChanged: _filterBrands, // Call the filter function on text change
                decoration: InputDecoration(
                  hintText: 'Search Local Brands',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: filteredBrands.isEmpty && query.isNotEmpty
                  ? Center(child: Text("No brands found."))
                  : ListView.builder(
                itemCount: filteredBrands.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(
                      filteredBrands[index]['image']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(filteredBrands[index]['name']!),
                    onTap: () {
                      int selectedIndex = brandList.indexOf(filteredBrands[index]);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreenWrapper(
                            selectedBrand: filteredBrands[index]['name'],
                            selectedBrandIndex: selectedIndex, // Pass the index
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}