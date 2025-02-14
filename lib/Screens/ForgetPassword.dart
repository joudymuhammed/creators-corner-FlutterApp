import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final Dio _dio = Dio();

  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final String apiUrl = 'https://creatorscorner.runasp.net/api/Customer/forget-password';
    final Map<String, dynamic> body = {"email": _emailController.text.trim()};

    try {
      final response = await _dio.post(apiUrl, data: body);

      final Map<String, dynamic> responseData = response.data;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'] ?? 'Something went wrong!')),
      );

      if (responseData['status'] == true) {
        Navigator.pop(context);
      }
    } on DioException catch (error) {
      setState(() => _isLoading = false);

      String errorMessage = 'Failed to reset password. Please try again.';
      if (error.response != null && error.response!.data != null) {
        errorMessage = error.response!.data['message'] ?? errorMessage;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('Images/Super_Stars-removebg.png', height: 160),
              SizedBox(height: 20),
              Text('Forgot Password', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Text('Enter your email to reset your password.', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value!.isEmpty ? 'Email is required' : null,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Color(0xFFB0A5A5), Color(0xFFFF7B7B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : resetPassword,
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.black)
                      : Text('Reset Password', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text('Back to Sign In', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
