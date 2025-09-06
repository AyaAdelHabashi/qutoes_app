import 'package:flutter/material.dart';
import 'package:qutoes_app/core/model/user_model.dart';
import 'package:qutoes_app/core/shared_prefrance.dart';
import 'package:qutoes_app/feature/auth/service/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? user;
  bool isLoading = false;
  String? errorMessage;

  Future<void> register(String name, String email, String password) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final newUser = await AuthService.register(name, email, password);
      user = newUser;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      final loggedInUser = await AuthService.login(email, password);
      await CacheHelper.saveData(key: "token", value: loggedInUser?.token);
      user = loggedInUser;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
