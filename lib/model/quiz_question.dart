import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuizQuestion {
  final String question;
  final String reponse;
  final List<String> autres;

  QuizQuestion({
    required this.question,
    required this.reponse,
    required this.autres,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question'],
      reponse: json['reponse'],
      autres: List<String>.from(json['autres']),
    );
  }

  List<String> propositions() {
    final answers = <String>[reponse, ...autres];

    answers.shuffle();
    return answers;
  }
}
