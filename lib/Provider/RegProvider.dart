// reg_provider.dart
import 'package:flutter/material.dart';
import '../Models/registerationModel.dart';
import '../Services/RegisterationService.dart';

class RegProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> register(User user) async {
    _isLoading = true;
    notifyListeners();

    bool success = await _authService.register(user);

    _isLoading = false;
    notifyListeners();

    return success;
  }
}
