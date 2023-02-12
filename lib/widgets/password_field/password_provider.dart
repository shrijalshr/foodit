import 'package:flutter/material.dart';

class PasswordProvider with ChangeNotifier {
  bool _showPassword = false;

  bool get showPassword => _showPassword;

  togglePassword(value) {
    _showPassword = !value;
    notifyListeners();
  }
}
