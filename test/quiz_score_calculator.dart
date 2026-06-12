import 'package:flutter_test/flutter_test.dart';
import 'package:acteurs/service/quiz_score_calculator.dart';

void main() {
  group('QuizScoreCalculator', () {
    test('donne 0 point si la réponse est fausse', () {
      final calculator = QuizScoreCalculator();

      final score = calculator.calculateQuestionScore(
        isCorrect: false,
        secondsLeft: 10,
      );

      expect(score, 0);
    });

    test('donne plus de points si la réponse est rapide', () {
      final calculator = QuizScoreCalculator();

      final fastScore = calculator.calculateQuestionScore(
        isCorrect: true,
        secondsLeft: 12,
      );

      final slowScore = calculator.calculateQuestionScore(
        isCorrect: true,
        secondsLeft: 2,
      );

      expect(fastScore, greaterThan(slowScore));
    });
  });
}