class QuizScoreCalculator {
  static const int correctAnswerPoints = 100;
  static const int timeBonusBySecond = 10;

  int calculateQuestionScore({
    required bool isCorrect,
    required int secondsLeft,
  }) {
    if (!isCorrect) return 0;
    return correctAnswerPoints + (secondsLeft * timeBonusBySecond);
  }

  bool isEliminated({
    required int secondsLeft,
  }) {
    return secondsLeft <= 0;
  }
}
