import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/quiz.dart';
import '../model/quiz_theme.dart';

class QuizService {
  Future<List<QuizTheme>> fetchThemes() async {
    final response = await http.get(
      Uri.parse('https://api.neotech.fr/quizzes?select=quiz_id,quiz'),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur API lors du chargement des thèmes');
    }

    final List data = jsonDecode(response.body) as List;
    return data
        .map((theme) => QuizTheme.fromJson(theme as Map<String, dynamic>))
        .toList();
  }

  Future<Quiz> fetchQuiz(int quizId) async {
    final response = await http.get(
      Uri.parse('https://api.neotech.fr/quizzes?quiz_id=eq.$quizId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur API lors du chargement du quiz');
    }

    final List data = jsonDecode(response.body) as List;
    if (data.isEmpty) {
      throw Exception('Quiz introuvable');
    }

    return Quiz.fromJson(data.first as Map<String, dynamic>);
  }
}
