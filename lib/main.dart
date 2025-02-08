import 'package:flutter/material.dart';
import 'Component/NavBar.dart';
import 'Provider/CartProvider.dart';
import 'Provider/OrderProvider.dart';
import 'Provider/favProvider.dart';
import 'Screens/Account.dart';
import 'Screens/Browse.dart';
import 'Screens/Home.dart';
import 'Screens/MyCart.dart';
import 'Screens/Search.dart';
import 'Screens/Signin.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrdersProvider()), // Add OrdersProvider
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()), // Add the FavoritesProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signin(),
    );
  }
}

class CustomBottomNavBar extends StatefulWidget {

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    BrowseScreen(),
    SearchScreen(),
    HomeScreen(),
    MyCart(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomAppBar(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB0A5A5), Color(0xFFFF7B7B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomNavItem(
                      icon: Icons.apps,
                      label: 'Browse',
                      isSelected: _selectedIndex == 0,
                      onTap: () => _onItemTapped(0),
                    ),
                    BottomNavItem(
                      icon: Icons.search,
                      label: 'Search',
                      isSelected: _selectedIndex == 1,
                      onTap: () => _onItemTapped(1),
                    ),
                    SizedBox(width: 60), // Spacer for the center Home button
                    BottomNavItem(
                      icon: Icons.shopping_cart,
                      label: 'Cart',
                      isSelected: _selectedIndex == 3,
                      onTap: () => _onItemTapped(3),
                    ),
                    BottomNavItem(
                      icon: Icons.person,
                      label: 'Account',
                      isSelected: _selectedIndex == 4,
                      onTap: () => _onItemTapped(4),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -25,
              left: MediaQuery.of(context).size.width / 2 - 40,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                ),
                child: IconButton(
                  icon: Icon(Icons.home, color: Colors.black),
                  onPressed: () => _onItemTapped(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}