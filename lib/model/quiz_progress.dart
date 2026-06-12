import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuizProgress {
  final int quizId;
  final int bestScore;
  final int played;

  QuizProgress({
    required this.quizId,
    required this.bestScore,
    required this.played,
  });

  factory QuizProgress.fromJson(Map<String, dynamic> json) {
    return QuizProgress(
      quizId: json['quizId'] ?? 0,
      bestScore: json['bestScore'] ?? 0,
      played: json['played'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'quizId': quizId, 'bestScore': bestScore, 'played': played};
  }
}
