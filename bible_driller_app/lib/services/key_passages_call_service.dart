// book_call_service.dart
import 'dart:convert';  // To decode JSON
import 'package:flutter/services.dart';  // For loading assets
import '../models/key_passages_call_model.dart';  // Import the model

class KeyPassagesCallService {
  Future<List<KeyPassagesCallModel>> loadKeyPassageCalls() async {
    final String jsonString = await rootBundle.loadString('assets/data/keyPassages.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((json) => KeyPassagesCallModel.fromJson(json)).toList();
  }
}
