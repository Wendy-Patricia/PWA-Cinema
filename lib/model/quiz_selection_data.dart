import '../model/quiz_progress.dart';
import '../model/quiz_theme.dart';

class _QuizSelectionData {
  final List<QuizTheme> themes;
  final Map<int, QuizProgress> progress;

  const _QuizSelectionData({required this.themes, required this.progress});
}
