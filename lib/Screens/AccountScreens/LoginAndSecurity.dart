import 'package:flutter/material.dart';

class LoginAndSecurityPage extends StatefulWidget {
  @override
  _LoginAndSecurityPageState createState() => _LoginAndSecurityPageState();
}

class _LoginAndSecurityPageState extends State<LoginAndSecurityPage> {
  bool isTwoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login & Security"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildListTile(
              title: "Email",
              subtitle: "user@example.com",
              icon: Icons.email,
              onTap: () {
              },
            ),
            _buildDivider(),

            _buildListTile(
              title: "Password",
              subtitle: "********",
              icon: Icons.lock,
              onTap: () {
                // Navigate to change password screen
              },
            ),
            _buildDivider(),

            _buildListTile(
              title: "Two-Factor Authentication",
              subtitle: isTwoFactorEnabled ? "Enabled" : "Disabled",
              icon: Icons.security,
              trailing: Switch(
                value: isTwoFactorEnabled,
                onChanged: (value) {
                  setState(() {
                    isTwoFactorEnabled = value;
                  });
                },
              ),
            ),
            _buildDivider(),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom( backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Handle logout logic
                },
                child: Text("Logout", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: trailing ?? Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      height: 1,
    );
  }
}