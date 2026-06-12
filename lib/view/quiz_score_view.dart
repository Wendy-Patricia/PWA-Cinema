import 'package:flutter/material.dart';

import '../model/player_gender.dart';
import '../service/quiz_progress_service.dart';

class QuizScoreView extends StatefulWidget {
  final String playerName;
  final PlayerGender gender;
  final int quizId;
  final String quizTitle;
  final int score;
  final int correctAnswers;
  final int totalQuestions;

  const QuizScoreView({
    super.key,
    required this.playerName,
    required this.gender,
    required this.quizId,
    required this.quizTitle,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  State<QuizScoreView> createState() => _QuizScoreViewState();
}

class _QuizScoreViewState extends State<QuizScoreView>
    with SingleTickerProviderStateMixin {
  final QuizProgressService _progressService = QuizProgressService();

  late AnimationController _controller;
  late Animation<double> _dropAnimation;
  late Animation<int> _scoreAnimation;

  @override
  void initState() {
    super.initState();

    _progressService.saveResult(
      quizId: widget.quizId,
      score: widget.score,
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _dropAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    _scoreAnimation = IntTween(
      begin: 0,
      end: widget.score,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  String get _levelName {
    final percent = widget.totalQuestions == 0
        ? 0
        : widget.correctAnswers / widget.totalQuestions;

    if (percent <= 0.33) {
      return 'Débutant';
    } else if (percent <= 0.66) {
      return 'Intermédiaire';
    } else {
      return 'Expert cinéma';
    }
  }

  String get _performanceImagePath {
    final percent = widget.totalQuestions == 0
        ? 0
        : widget.correctAnswers / widget.totalQuestions;

    final suffix = widget.gender == PlayerGender.femme ? 'f' : '';

    if (percent <= 0.33) {
      return 'assets/images/level1$suffix.png';
    } else if (percent <= 0.66) {
      return 'assets/images/level2$suffix.png';
    } else {
      return 'assets/images/level3$suffix.png';
    }
  }

  void _backToSelection() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.totalQuestions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultat'),
        backgroundColor: const Color(0xFF7B2CBF),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              height: 190,
              child: AnimatedBuilder(
                animation: _dropAnimation,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment(
                      0,
                      -1 + (1.1 * _dropAnimation.value),
                    ),
                    child: child,
                  );
                },
                child: Image.asset(
                  _performanceImagePath,
                  height: 130,
                ),
              ),
            ),
            Text(
              'Bravo ${widget.playerName} !',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(widget.quizTitle, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text(
              'Niveau : $_levelName',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7B2CBF),
              ),
            ),
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: _scoreAnimation,
              builder: (context, child) {
                return Text(
                  '${_scoreAnimation.value} pts',
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B2CBF),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.correctAnswers}/$total bonnes réponses',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _backToSelection,
                icon: const Icon(Icons.list),
                label: const Text('Retour à la sélection du quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}