import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/shared_prefrance.dart';
import 'package:qutoes_app/feature/MyQutoes/ui/MyQutoes.dart';
import 'package:qutoes_app/feature/home/ui/home.dart';
import 'package:qutoes_app/feature/home/ui/widgets/bottom_nav.dart';
import 'package:qutoes_app/feature/loves/ui/loves.dart';
import 'package:qutoes_app/feature/profile/ui/profile.dart';
import 'package:http/http.dart' as http;

class MainProvider extends ChangeNotifier {
  int currentIndex = 0;
  bool getQuotesLoading = false;
  List quotes = [];
  void getQuotes() async {
    getQuotesLoading = true;
    notifyListeners();
    final quotes = await http.get(Uri.parse('https://article-api-z472.onrender.com/api/articles'));
    this.quotes = jsonDecode(quotes.body);
    getQuotesLoading = false;
    notifyListeners();
  }

  List quatesResult = [];
  TextEditingController searchQuotesController = TextEditingController();
  searchQuates() async {
    final result = quotes.where((element) => element['title'].toLowerCase().contains(searchQuotesController.text.toLowerCase()));
    quatesResult = result.toList();
    notifyListeners();
  }

  bool addQuotesLoading = false;
  TextEditingController addTitleQuotesController = TextEditingController();
  TextEditingController addContentQuotesController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future addQuotes(BuildContext context) async {
    addQuotesLoading = true;
    notifyListeners();

    try {
      // التحقق من وجود التوكين
      final token = await CacheHelper.getData(key: 'token');
      if (token == null || token.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Token is missing or invalid'), backgroundColor: Colors.red));
        addQuotesLoading = false;
        notifyListeners();
        return;
      }

      // طباعة التوكين للمراجعة
      print('Token: $token');
      print('Title: ${addTitleQuotesController.text}');
      print('Content: ${addContentQuotesController.text}');

      // إرسال الطلب باستخدام JSON و Bearer token
      final response = await http.post(
        Uri.parse('https://article-api-z472.onrender.com/api/articles'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token', // استخدام Bearer مع التوكين
          'x-auth-token': '$token',
        },
        body: jsonEncode({'title': addTitleQuotesController.text, 'content': addContentQuotesController.text}),
      );

      // التعامل مع الرد
      if (response.statusCode == 200) {
        addQuotesLoading = false;
        notifyListeners();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Quote added successfully'), backgroundColor: Colors.green));
        getQuotes(); // استرجاع الاقتباسات بعد إضافة اقتباس جديد
        print('Response Body: ${response.body}');
      } else {
        addQuotesLoading = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add quote'), backgroundColor: Colors.red));
        print('Failed Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      addQuotesLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred while adding the quote'), backgroundColor: Colors.red));
    }
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> screens = [const MainScreen(), const MyQutoes(), Loves(), const Profile()];
  List<String> title(BuildContext context) => [tr('home'), tr('my_quotes'), tr('loves'), tr('profile')];
  List<BottomNavigationBarItem> items(BuildContext context) => [
    BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/home.svg'), label: context.tr('home')),
    BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/document-text.svg'), label: context.tr('my_quotes')),
    BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/heart.svg'), label: context.tr('loves')),
    BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/user.svg'), label: context.tr('profile')),
  ];
}
