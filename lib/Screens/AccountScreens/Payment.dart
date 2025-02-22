import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildHeader("Manage Your Payment Methods"),
            SizedBox(height: 20),
            _buildPaymentMethodCard(
              title: "Add New Payment Method",
              subtitle: "Add a credit or debit card",
              icon: Icons.add_card,
              onTap: () {
              },
            ),
            _buildPaymentMethodCard(
              title: "Credit/Debit Cards",
              subtitle: "Manage your saved cards",
              icon: Icons.credit_card,
              onTap: () {
              },
            ),
            _buildPaymentMethodCard(
              title: "PayPal",
              subtitle: "Link your PayPal account",
              icon: Icons.paypal,
              onTap: () {
              },
            ),
            _buildPaymentMethodCard(
              title: "Payment History",
              subtitle: "View your transaction history",
              icon: Icons.history,
              onTap: () {
              },
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent.withOpacity(0.1),
          child: Icon(icon, color: Colors.green),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}