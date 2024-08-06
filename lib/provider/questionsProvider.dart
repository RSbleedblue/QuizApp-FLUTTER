import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class QuestionsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _questions = [];

  List<Map<String, dynamic>> get questions => _questions;

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString('lib/assets/questions.json');
    final data = await json.decode(response) as List;
    _questions = data.map((question) => question as Map<String, dynamic>).toList();
    notifyListeners();
  }
}
