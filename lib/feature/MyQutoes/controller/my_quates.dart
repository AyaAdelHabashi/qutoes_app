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
  Future<void> deleteQuote(String id) async {
    deleteLoading = true;
    notifyListeners();
    try {
      final response = await http.delete(
        Uri.parse('https://article-api-z472.onrender.com/api/articles/:$id'),
        headers: {'x-auth-token': await CacheHelper.getData(key: 'token')},
      );
      if (response.statusCode == 200) {
        getQuotes();
      } else {
        print(response.statusCode);
      }
      deleteLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      deleteLoading = false;
      print(e);
      notifyListeners();
    } finally {
      deleteLoading = false;
      notifyListeners();
    }
  }

  bool updateLoading = false;
  Future<void> updateQuote(String id, String title, String content) async {
    isLoading = true;
    notifyListeners();
    try {
      await http.put(
        Uri.parse('https://article-api-z472.onrender.com/api/articles/$id'),
        body: jsonEncode({'title': title, 'content': content}),
        headers: {'x-auth-token': await CacheHelper.getData(key: 'token')},
      );
      updateLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      updateLoading = false;
      notifyListeners();
    } finally {
      updateLoading = false;
      notifyListeners();
    }
  }
}
