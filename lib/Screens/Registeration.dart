import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Models/registerationModel.dart';
import '../Provider/RegProvider.dart';
import '../main.dart';
import 'signin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ImgController = TextEditingController();

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final regProvider = Provider.of<RegProvider>(context, listen: false);
    User newUser = User(
      name: _nameController.text,
      email: _emailController.text,
      imageUrl: _ImgController.text,
      address: _addressController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      phoneNumber: _phoneNumberController.text,
    );

    bool success = await regProvider.register(newUser);

    if (success) {
      // Save username in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('customerUsername', _usernameController.text);

      // Navigate to Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final regProvider = Provider.of<RegProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Image.asset('Images/Super_Stars-removebg.png', height: 160),
                SizedBox(height: 20),
                Text('Register', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Text('Please register to login.', style: TextStyle(fontSize: 16, color: Colors.black)),
                SizedBox(height: 20),

                _buildTextField(_nameController, 'Name', Icons.person),
                _buildTextField(_emailController, 'Email', Icons.email),
                _buildTextField(_addressController, 'Address', Icons.home),
                _buildTextField(_passwordController, 'Password', Icons.lock, isPassword: true),
                _buildTextField(_usernameController, 'Username', Icons.account_circle),
                _buildTextField(_phoneNumberController, 'Phone Number', Icons.phone),
                _buildTextField(_ImgController, 'Image', Icons.image),


                SizedBox(height: 20),

                regProvider.isLoading
                    ? CircularProgressIndicator()
                    : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Color(0xFFB0A5A5), Color(0xFFFF7B7B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                      child: ElevatedButton(
                                        onPressed: _register,
                                        child: Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black)),
                                        style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                                        ),
                                      ),
                    ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?', style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Signin())),
                      child: Text(' Sign in', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) => value!.isEmpty ? '$label is required' : null,
      ),
    );
  }
}
