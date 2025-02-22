import 'dart:convert';
import 'dart:io';
import 'package:creators_corner/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Models/registerationModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/RegProvider.dart';
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

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      _showSnackBar("No image selected.");
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    String? base64Image;
    if (_imageFile != null) {
      final bytes = await _imageFile!.readAsBytes();
      base64Image = base64Encode(bytes);
    }

    final regProvider = Provider.of<RegProvider>(context, listen: false);
    User newUser = User(
      name: _nameController.text,
      email: _emailController.text,
      image: base64Image,
      address: _addressController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      phoneNumber: _phoneNumberController.text,
    );

    // Print the JSON payload here
    print("User   JSON Payload: ${newUser .toJson()}");

    try {
      bool success = await regProvider.register(newUser);
      if (success) {
        // Handle successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomBottomNavBar()), // Navigate to the home page
        );

        // Optionally, store user information in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', _emailController.text);
      } else {
        // Handle registration failure
        _showSnackBar("Registration failed. Please try again.");
      }
    } catch (e) {
      // Log the error and show a message to the user
      print("Error during registration: $e");
      _showSnackBar("An error occurred during registration. Please try again.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
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
                _buildImagePicker(),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : _buildRegisterButton(),
                SizedBox(height: 10),
                _buildSignInPrompt(),
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

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(Icons.image, color: Colors.grey),
            SizedBox(width: 10),
            Text(
              _imageFile == null ? 'Pick an Image' : 'Image Selected',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
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
        child: Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildSignInPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?', style: TextStyle(color: Colors.grey)),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Signin())),
          child: Text(' Sign in', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}