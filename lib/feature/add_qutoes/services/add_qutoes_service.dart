import 'dart:convert';
import 'package:http/http.dart' as http;

class AddQuoteService {
  static const String baseUrl = "https://article-api-z472.onrender.com/api";

  static Future<bool> addQuote(String content, String type, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/quotes"),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": token,
      },
      body: jsonEncode({
        "content": content,
        "type": type,
      }),
    );

    if (response.statusCode == 201) {
      return true; 
    } else {
      throw Exception("فشل إضافة الاقتباس: ${response.body}");
    }
  }
}
