import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qutoes_app/core/shared_prefrance.dart';
import 'package:qutoes_app/core/theme/colors.dart';

class ProfileController extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  Map user = {};
  Future<void> getUser() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await http.get(
        Uri.parse('https://article-api-z472.onrender.com/api/users/me'),
        headers: {
          'x-auth-token': await CacheHelper.getData(key: 'token'),
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        user = jsonDecode(response.body);
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        errorMessage = response.body;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  TextEditingController nameController = TextEditingController();
  bool updateProfileLoading = false;
  final formKey = GlobalKey<FormState>();
  String? updateProfileErrorMessage;
  Future<void> updateProfile({required BuildContext context}) async {
    updateProfileLoading = true;
    notifyListeners();
    try {
      final response = await http.put(
        Uri.parse('https://article-api-z472.onrender.com/api/users/me'),
        body: jsonEncode({'name': nameController.text}),
        headers: {
          'x-auth-token': await CacheHelper.getData(key: 'token'),
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        await getUser();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم تحديث الاسم بنجاح")));
        print(response.statusCode);
        Navigator.pop(context);
        nameController.clear();
        updateProfileLoading = false;
        notifyListeners();
      } else {
        updateProfileErrorMessage = response.body;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل تحديث الاسم")));
        updateProfileLoading = false;
        print(response.statusCode);
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      updateProfileErrorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل تحديث الاسم")));
      updateProfileLoading = false;
      print(e);
      notifyListeners();
    }
  }

  bool changePasswordLoading = false;
  final changePasswordFormKey = GlobalKey<FormState>();
  String? changePasswordErrorMessage;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  Future<void> changePassword({required BuildContext context}) async {
    changePasswordLoading = true;
    notifyListeners();
    try {
      final response = await http.put(
        Uri.parse('https://article-api-z472.onrender.com/api/auth/changepassword'),
        body: jsonEncode({"oldPassword": oldPasswordController.text, "newPassword": newPasswordController.text}),
        headers: {
          'x-auth-token': await CacheHelper.getData(key: 'token'),
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.tr("تم تحديث كلمة المرور بنجاح")), backgroundColor: Colors.green));
        changePasswordLoading = false;
        oldPasswordController.clear();
        newPasswordController.clear();
        Navigator.pop(context);
        notifyListeners();
      } else {
        print(response.statusCode);
        changePasswordErrorMessage = response.body;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr("فشل تحديث كلمة المرور"))));
        changePasswordLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      changePasswordErrorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr("فشل تحديث كلمة المرور"))));
      changePasswordLoading = false;
      print(e);
      notifyListeners();
    }
  }
}
