import 'package:flutter/material.dart';
import 'package:psych_diagnosis_admin/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
