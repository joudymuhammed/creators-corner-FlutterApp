import 'package:dio/dio.dart';
import '../Models/loginModel.dart';
import '../Models/registerationModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';


class AuthService {
  final Dio _dio = Dio();




  Future<bool> register(User user) async {
    try {
      Response response = await _dio.post(
        'https://creatorscorner.runasp.net/api/Customer/register',
        data: {
          "name": user.name,
          "email": user.email,
          "address": user.address,
          "password": user.password,
          "username": user.username,
          "phoneNumber": user.phoneNumber,
          "image": user.image,
        },
      );

      if (response.statusCode == 200) {
        print("✅ Registration Successful!");
        return true;
      } else {
        print("❌ Registration Failed: ${response.statusCode}, ${response.data}");
        return false;
      }
    } catch (e) {
      print("🚨 Error during registration: $e");
      return false;
    }
  }


  Future<String?> getUsername() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('customerUsername');
  }




  Future<LoginResponse> login(LoginRequest request) async {
    try {
      Response response = await _dio.post(
        'https://creatorscorner.runasp.net/api/Customer/login',
        data: request.toJson(),
      );

      print("API Response: ${response.data}");

      if (response.statusCode == 200 && response.data['status']) {
        String customerId = response.data['data']['id'].toString();
        String username = response.data['data']['username'];

        // Save customerId & username to SharedPreferences
        final preferences = await SharedPreferences.getInstance();
        await preferences.setInt('customerId', int.parse(customerId));
        await preferences.setString('customerUsername', username);

        print("✅ Customer ID saved: $customerId");
        print("✅ Username saved: $username");

        return LoginResponse.fromJson(response.data);
      } else {
        print("❌ Login failed: ${response.data['message']}");
        return LoginResponse(success: false, message: response.data['message']);
      }
    } catch (e) {
      print("❌ Login failed! Error: $e");
      return LoginResponse(success: false, message: 'Login failed. Please check your username or password.');
    }
  }
  }

