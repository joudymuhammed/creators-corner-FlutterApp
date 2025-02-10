import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/favProvider.dart';
import 'AccountScreens/Customer Service/CustomerService.dart';
import 'AccountScreens/LoginAndSecurity.dart';
import 'AccountScreens/Orders.dart';
import 'AccountScreens/Payment.dart';
import 'AccountScreens/chat/Chat.dart';
import 'AccountScreens/Favourits.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context); // Access the provider

    final List<Map<String, dynamic>> listItems = [
      {"title": "Your Orders", 'subtitle': "Track, return, cancel an order.", "image": "Images/orders.jpg", "page": OrdersPage()},
      {"title": "Favorites", 'subtitle': "Your preferred products in one place.", "image": "Images/favorite.png"},
      {"title": "Messages", 'subtitle': "View and respond to your messages.", "image": "Images/coloredMsg.png", "page":ChatListScreen()},
      {"title": "Payments", 'subtitle': "Manage your payment methods and settings.", "image": "Images/payment1.jpg", "page": PaymentPage()},
      {"title": "Login & security", 'subtitle': "Manage your login and security settings.", "image": "Images/Security1.png", "page": LoginAndSecurityPage()},
      {"title": "Customer Service", 'subtitle': "Contact support, browse help articles, and resolve issues.", "image": "Images/CustServ.png", "page": CustomerServicePage()},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Account")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.account_circle_rounded,),
                  radius: 26,
                  backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                ),
                SizedBox(width: 20),
                Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Divider(color: Colors.grey, thickness: 1),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (listItems[index]["title"] == "Favorites") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavouritesPage(favoriteProducts: [], ),
                        ),
                      );
                    } else if (listItems[index]["title"] == "Your Orders") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrdersPage()), // Navigate to OrdersPage
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => listItems[index]["page"]),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7, bottom: 37),
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(listItems[index]["image"]),
                              radius: 35,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listItems[index]["title"],
                                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  listItems[index]["subtitle"],
                                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}