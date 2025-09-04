import 'package:flutter/material.dart';
import '../services/add_qutoes_service.dart';

class AddQuoteController with ChangeNotifier {
  final TextEditingController quoteController = TextEditingController();
  String? selectedType;
  bool isLoading = false;
  String? errorMessage;

  void selectType(String? type) {
    selectedType = type;
    notifyListeners();
  }

  Future<void> publishQuote(String token) async {
    if (quoteController.text.isEmpty || selectedType == null) {
      errorMessage = "يرجى كتابة نص الاقتباس واختيار النوع";
      notifyListeners();
      return;
    }

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await AddQuoteService.addQuote(
        quoteController.text,
        selectedType!,
        token,
      );

      quoteController.clear();
      selectedType = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
