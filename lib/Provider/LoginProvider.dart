import 'package:flutter/material.dart';

import '../Models/loginModel.dart';
import '../Services/RegisterationService.dart';

class LoginProvider with ChangeNotifier {
  final  AuthService _authService = AuthService();
  bool isLoading = false;
  String? errorMessage;
  late LoginRequest loginrequest;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    notifyListeners();

    LoginResponse response = await _authService.login(
      LoginRequest(username: username, password: password),
    );

    isLoading = false;
    notifyListeners();

    if (response.success) {
      return true;
    } else {
      errorMessage = response.message;
      return false;
    }
  }
}
