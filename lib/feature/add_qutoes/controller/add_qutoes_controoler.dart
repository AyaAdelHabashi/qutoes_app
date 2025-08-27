import 'package:flutter/material.dart';

class AddQuoteController extends ChangeNotifier {
  String? selectedType;
  final TextEditingController quoteController = TextEditingController();

  void selectType(String? value) {
    selectedType = value;
    notifyListeners();
  }

  void publishQuote() {
    if (selectedType == null || quoteController.text.isEmpty) {
      // لاحقاً بنضيف SnackBar أو validation
      return;
    }
    // إرسال البيانات للسيرفر أو حفظها
    debugPrint("نوع الاقتباس: $selectedType");
    debugPrint("النص: ${quoteController.text}");
  }
}
