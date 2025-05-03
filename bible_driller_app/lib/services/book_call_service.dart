// book_call_service.dart
import 'dart:convert';  // To decode JSON
import 'package:flutter/services.dart';  // For loading assets
import '../models/book_call_model.dart';  // Import the model

class BookCallService {
  Future<List<BookCallModel>> loadBookCalls() async {
    final String jsonString = await rootBundle.loadString('assets/data/bibleBooks.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((json) => BookCallModel.fromJson(json)).toList();
  }
}
