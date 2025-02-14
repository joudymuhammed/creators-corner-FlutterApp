import 'package:dio/dio.dart';
import '../Models/loginModel.dart';
import '../Models/registerationModel.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<bool> register(User user) async {
    try {
      Response response = await _dio.post(
        'https://creatorscorner.runasp.net/api/Customer/register',
        data: user.toJson(),
      );

      if (response.statusCode == 200) {
        print(" Registration Successful!");
        return true;
      } else {
        print(" Registration Failed: ${response.data}");
        return false;
      }
    } catch (e) {
      print(" Error during registration: $e");
      return false;
    }
  }



  Future<LoginResponse> login(LoginRequest request) async {
    try {
      Response response = await _dio.post(
        'https://creatorscorner.runasp.net/api/Customer/login',
        data: request.toJson(),
      );

      print("API Response: ${response.data}");

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        return LoginResponse(success: false, message: 'Invalid credentials');
      }
    } catch (e) {
      return LoginResponse(success: false, message: 'Login failed please check your email or password');
    }
  }
  }

