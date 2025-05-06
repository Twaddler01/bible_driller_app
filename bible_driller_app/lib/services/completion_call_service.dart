// completion_call_service.dart
import 'dart:convert';  // To decode JSON
import 'package:flutter/services.dart';  // For loading assets
import '../models/completion_call_model.dart';  // Import the model

class CompletionCallService {
  Future<List<CompletionCallModel>> loadCompletionCalls() async {
    final String jsonString = await rootBundle.loadString('assets/data/bibleVerses.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((json) => CompletionCallModel.fromJson(json)).toList();
  }
}