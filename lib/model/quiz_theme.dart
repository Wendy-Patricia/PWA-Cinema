import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuizTheme {
  final int quizId;
  final String quiz;

  QuizTheme
  (
    {
      required this.quizId, 
      required this.quiz
    }
  );

  factory QuizTheme.fromJson(Map<String, dynamic> json) {
    return QuizTheme(quizId: json['quiz_id'], quiz: json['quiz']);
  }
}
