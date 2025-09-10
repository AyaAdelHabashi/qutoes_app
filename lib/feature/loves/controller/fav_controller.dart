import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qutoes_app/core/shared_prefrance.dart';

class FavController extends ChangeNotifier {
  Set<String> _favoriteQuoteIds = {};
  List _favoriteQuotes = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters للوصول للحالة من الواجهة
  Set<String> get favoriteQuoteIds => _favoriteQuoteIds;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List get allfavoriteQuotes => _favoriteQuotes;
  // دالة مساعدة للتحقق بسهولة إذا كان الاقتباس في المفضلة
  bool isFavorite(String quoteId) {
    return _favoriteQuoteIds.contains(quoteId);
  }

  // جلب المفضلة لأول مرة عند فتح التطبيق
  Future<void> getInitialFavQuotes() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse('https://article-api-z472.onrender.com/api/favorites'),
        headers: {'x-auth-token': await CacheHelper.getData(key: 'token')},
      );

      print("fave${response.body}");
      if (response.statusCode == 200) {
        final List favQuotesData = jsonDecode(response.body);

        _favoriteQuoteIds = favQuotesData.map((quote) => quote['_id'] as String).toSet();
        _favoriteQuotes = List.from(favQuotesData);
        _isLoading = false;
        notifyListeners();
      } else {
        _errorMessage = "Failed to load favorites";
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  // 🔥 الدالة الاحترافية لتبديل حالة المفضلة
  Future<void> toggleFavorite(String quoteId, BuildContext context) async {
    final bool isCurrentlyFavorite = isFavorite(quoteId);

    // 💡 الخطوة 1: تحديث الواجهة فورًا (Optimistic Update)
    if (isCurrentlyFavorite) {
      _favoriteQuoteIds.remove(quoteId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم حذف الاقتباس من المفضلة")));
    } else {
      _favoriteQuoteIds.add(quoteId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم إضافة الاقتباس إلى المفضلة")));
    }
    notifyListeners(); // تحديث الواجهة فورًا

    // الخطوة 2: إرسال الطلب للخادم في الخلفية
    try {
      final uri = Uri.parse('https://article-api-z472.onrender.com/api/favorites/$quoteId');
      //  final headers = ;

      http.Response response;
      if (isCurrentlyFavorite) {
        // كان في المفضلة، إذًا سنقوم بحذفه
        response = await http.delete(
          uri,
          headers: {
            'x-auth-token': await CacheHelper.getData(key: 'token'),
            'Content-Type': 'application/json',
          },
        );
      } else {
        // لم يكن في المفضلة، إذًا سنقوم بإضافته
        response = await http.post(
          uri,
          headers: {
            'x-auth-token': await CacheHelper.getData(key: 'token'),
            'Content-Type': 'application/json',
          },
        );
      }
      await getInitialFavQuotes();
      print(response.body);
      // إذا فشل الطلب من الخادم (مثلاً خطأ 400 أو 500)
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to update favorite on server');
      }

      // إذا نجح الطلب، لا نفعل شيئًا لأن الواجهة محدثة بالفعل
    } catch (e) {
      // ⚠️ الخطوة 3: التراجع عن التغيير في حالة فشل الطلب (Rollback)
      print(e);
      if (isCurrentlyFavorite) {
        _favoriteQuoteIds.add(quoteId); // أضفه مرة أخرى
      } else {
        _favoriteQuoteIds.remove(quoteId); // احذفه مرة أخرى
      }

      notifyListeners(); // أعد الواجهة لحالتها الأصلية

      // يمكنك هنا إظهار رسالة خطأ للمستخدم
      _errorMessage = "An error occurred. Please try again.";
      print(e);
    }
  }
}
