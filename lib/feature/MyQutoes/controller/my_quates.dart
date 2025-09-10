import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qutoes_app/core/shared_prefrance.dart';

class MyQuatesProvider extends ChangeNotifier {
  List quates = [];
  bool isLoading = false;
  String? errorMessage;
  Future<void> getQuotes() async {
    isLoading = true;
    notifyListeners();
    try {
      final quotes = await http.get(
        Uri.parse('https://article-api-z472.onrender.com/api/articles/myarticles'),
        headers: {'x-auth-token': await CacheHelper.getData(key: 'token')},
      );
      if (quotes.statusCode == 200) {
        quates = jsonDecode(quotes.body);
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        errorMessage = quotes.body;
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print(e);
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  bool deleteLoading = false;
  Future<void> deleteQuote({required String id, required BuildContext context}) async {
    deleteLoading = true;
    notifyListeners();
    try {
      final response = await http.delete(
        Uri.parse('https://article-api-z472.onrender.com/api/articles/$id'),
        headers: {'x-auth-token': await CacheHelper.getData(key: 'token')},
      );
      if (response.statusCode == 200) {
        getQuotes();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("تم حذف الاقتباس بنجاح"), backgroundColor: Colors.green));
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل حذف الاقتباس"), backgroundColor: Colors.red));
      }
      deleteLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      deleteLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل حذف الاقتباس"), backgroundColor: Colors.red));
      print(e);
      notifyListeners();
    }
  }

  bool updateLoading = false;
  String? updateErrorMessage;
  int? selectedUpdateId;
  toggleSelectedUpdateId(int? value) {
    selectedUpdateId = value;
    notifyListeners();
  }

  List<String> updatepdateCategory = ["أدب", "فلسفة", "تحفيز", "حكم"];
  Future<void> updateQuote({
    required String id,
    required String title,
    required String content,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    Navigator.pop(context);
    try {
      final response = await http.put(
        Uri.parse('https://article-api-z472.onrender.com/api/articles/$id'),
        body: jsonEncode({'title': title, 'content': content, 'category': updatepdateCategory[selectedUpdateId!]}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': await CacheHelper.getData(key: 'token'),
        },
      );
      if (response.statusCode == 200) {
        getQuotes();

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("تم تحديث الاقتباس بنجاح"), backgroundColor: Colors.green));
      } else {
        print(response.body);
        updateErrorMessage = response.body;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل تحديث الاقتباس"), backgroundColor: Colors.red));
      }
      updateLoading = false;
      notifyListeners();
    } catch (e) {
      updateErrorMessage = e.toString();
      updateLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فشل تحديث الاقتباس"), backgroundColor: Colors.red));
      notifyListeners();
    }
  }
}
