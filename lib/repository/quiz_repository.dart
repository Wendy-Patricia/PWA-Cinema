import '../model/quiz.dart';
import '../service/quiz_service.dart';
import '../model/quiz_theme.dart';

class QuizRepository {
  final QuizService _service;

  QuizRepository({QuizService? service}) : _service = service ?? QuizService();

  Future<List<QuizTheme>> getThemes() async {
    final themes = await _service.fetchThemes();
    themes.sort((a, b) => a.quiz.compareTo(b.quiz));
    return themes;
  }

  Future<Quiz> getQuiz(int quizId) {
    return _service.fetchQuiz(quizId);
  }
}
