import 'package:flutter/material.dart';
import 'Chating.dart'; // Ensure this is the correct import for your ChatScreen

class ChatListScreen extends StatelessWidget {
  final List<Map<String, String>> chatData = [
    {
      "name": "Twenty Seven",
      "lastMessage": "Check out our new collection!",
      "time": "10:30 AM",
      "avatar": "https://via.placeholder.com/150" // Placeholder image URL
    },
    {
      "name": "Vice",
      "lastMessage": "Don't miss our sale this weekend!",
      "time": "9:15 AM",
      "avatar": "https://via.placeholder.com/150"
    },
    {
      "name": "Laqta",
      "lastMessage": "Your order has been shipped!",
      "time": "Yesterday",
      "avatar": "https://via.placeholder.com/150"
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats with Local Brands"),
      ),
      body: ListView.builder(
        itemCount: chatData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(chatData[index]["avatar"]!),
              ),
              title: Text(
                chatData[index]["name"]!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                chatData[index]["lastMessage"]!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                chatData[index]["time"]!,
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                // Navigate to ChatScreen when a chat is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      chatTitle: chatData[index]["name"]!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}