import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: const Text("Contact Support"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildSupportCard(
                title: "Call Us",
                subtitle: "+20 123 456 7890",
                icon: Icons.phone,
                color: Colors.green,
                onTap: () => _launchPhone("+201234567890"),
              ),
              _buildSupportCard(
                title: "Email Support",
                subtitle: "support@example.com",
                icon: Icons.email,
                color: Colors.blue,
                onTap: () => _launchEmail("support@example.com"),
              ),
              _buildSupportCard(
                title: "Live Chat",
                subtitle: "Chat with a support agent",
                icon: Icons.chat,
                color: Colors.orange,
                onTap: () {
                  // Implement chat navigation
                },
              ),
            ],
          ),
        ));


  }

  Widget _buildSupportCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _launchPhone(String phoneNumber) async {
    final Uri url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  void _launchEmail(String email) async {
    final Uri url = Uri.parse("mailto:$email");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint("Could not launch $url");
    }
  }
}
