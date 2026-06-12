import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'quiz_question.dart';


class Quiz {
  final int quizId;
  final String quiz;
  final List<QuizQuestion> questions;

  Quiz({
    required this.quizId,
    required this.quiz,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      quizId: json['quiz_id'],
      quiz: json['quiz'],
      questions: (json['questions'] as List)
          .map((q) => QuizQuestion.fromJson(q))
          .toList(),
    );
  }
}