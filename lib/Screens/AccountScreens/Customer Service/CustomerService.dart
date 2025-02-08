import 'package:flutter/material.dart';

import 'C_Support.dart';

class CustomerServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Service"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildListTile(
              title: "Contact Support",
              subtitle: "Get in touch with our support team",
              icon: Icons.support_agent,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactSupportPage()));
              },
            ),
            _buildDivider(),

            _buildListTile(
              title: "FAQs",
              subtitle: "Frequently Asked Questions",
              icon: Icons.question_answer,
              onTap: () {
              },
            ),
            _buildDivider(),

            _buildListTile(
              title: "Submit Feedback",
              subtitle: "We value your feedback",
              icon: Icons.feedback,
              onTap: () {
              },
            ),
            _buildDivider(),

            _buildListTile(
              title: "Report an Issue",
              subtitle: "Let us know if you encounter any issues",
              icon: Icons.report_problem,
              onTap: () {
              },
            ),
            _buildDivider(),


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
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.redAccent),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
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