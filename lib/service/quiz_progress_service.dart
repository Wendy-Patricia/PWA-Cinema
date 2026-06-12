import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/quiz_progress.dart';

class QuizProgressService {
  static const String _prefix = 'quiz_progress_';
  static const String _playerNameKey = 'quiz_player_name';

  Future<void> savePlayerName(String name) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_playerNameKey, name);
  }

  Future<String?> getPlayerName() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_playerNameKey);
  }

  Future<QuizProgress> getProgress(int quizId) async {
    final preferences = await SharedPreferences.getInstance();
    final rawValue = preferences.getString('$_prefix$quizId');

    if (rawValue == null) {
      return QuizProgress(quizId: quizId, bestScore: 0, played: 0);
    }

    return QuizProgress.fromJson(jsonDecode(rawValue) as Map<String, dynamic>);
  }

  Future<Map<int, QuizProgress>> getAllProgress(List<int> quizIds) async {
    final entries = await Future.wait(quizIds.map(getProgress));
    return {for (final progress in entries) progress.quizId: progress};
  }

  Future<void> saveResult({
    required int quizId,
    required int score,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final oldProgress = await getProgress(quizId);

    final newProgress = QuizProgress(
      quizId: quizId,
      bestScore: score > oldProgress.bestScore ? score : oldProgress.bestScore,
      played: oldProgress.played + 1,
    );

    await preferences.setString(
      '$_prefix$quizId',
      jsonEncode(newProgress.toJson()),
    );
  }
}
