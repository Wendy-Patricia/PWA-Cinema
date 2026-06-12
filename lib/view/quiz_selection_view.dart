import 'package:custom_cached_image/custom_cached_image.dart';
import 'package:flutter/material.dart';

import '../model/player_gender.dart';
import '../model/quiz_progress.dart';
import '../model/quiz_theme.dart';
import '../repository/quiz_repository.dart';
import '../service/quiz_progress_service.dart';
import 'quiz_game_view.dart';

class QuizSelectionView extends StatefulWidget {
  final String playerName;
  final PlayerGender gender;

  const QuizSelectionView({
    super.key,
    required this.playerName,
    required this.gender,
  });

  @override
  State<QuizSelectionView> createState() => _QuizSelectionViewState();
}

class _QuizSelectionViewState extends State<QuizSelectionView> {
  final QuizRepository _repository = QuizRepository();
  final QuizProgressService _progressService = QuizProgressService();

  late Future<_QuizSelectionData> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _loadData();
  }

  Future<_QuizSelectionData> _loadData() async {
    final themes = await _repository.getThemes();
    final progress = await _progressService.getAllProgress(
      themes.map((theme) => theme.quizId).toList(),
    );

    themes.sort((a, b) {
      final aPlayed = progress[a.quizId]?.played ?? 0;
      final bPlayed = progress[b.quizId]?.played ?? 0;

      if (aPlayed == 0 && bPlayed > 0) return -1;
      if (aPlayed > 0 && bPlayed == 0) return 1;
      return a.quiz.compareTo(b.quiz);
    });

    return _QuizSelectionData(themes: themes, progress: progress);
  }

  Future<void> _openQuiz(QuizTheme theme) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizGameView(
          playerName: widget.playerName,
          quizId: theme.quizId,
          gender: widget.gender,
        ),
      ),
    );

    if (mounted) {
      setState(() {
        _futureData = _loadData();
      });
    }
  }

  String _imageUrl(int quizId) {
    return 'https://img.neotech.fr/cgi/images/tr:width=300/cinema%2fquiz%2f$quizId.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisir un quiz - ${widget.playerName}'),
        backgroundColor: const Color(0xFF7B2CBF),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<_QuizSelectionData>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erreur de chargement des quiz'));
          }

          final data = snapshot.data;
          if (data == null || data.themes.isEmpty) {
            return const Center(child: Text('Aucun quiz disponible'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: data.themes.length,
            itemBuilder: (context, index) {
              final theme = data.themes[index];
              final progress = data.progress[theme.quizId];
              final neverPlayed = progress == null || progress.played == 0;

              return Card(
                elevation: neverPlayed ? 6 : 2,
                child: InkWell(
                  onTap: () => _openQuiz(theme),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CustomCachedImage(
                            imageUrl: _imageUrl(theme.quizId),
                            width: 92,
                            height: 92,
                            borderRadius: 12,
                            fit: BoxFit.cover,
                            errorWidget: Image.asset(
                              'images/profile.jpg',
                              width: 92,
                              height: 92,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (neverPlayed)
                                const Text(
                                  'Nouveau thème',
                                  style: TextStyle(
                                    color: Color(0xFF7B2CBF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              Text(
                                theme.quiz,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                neverPlayed
                                    ? 'Pas encore joué'
                                    : 'Meilleur score : ${progress.bestScore} pts • ${progress.played} partie(s)',
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _QuizSelectionData {
  final List<QuizTheme> themes;
  final Map<int, QuizProgress> progress;

  const _QuizSelectionData({
    required this.themes,
    required this.progress,
  });
}