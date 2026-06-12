import 'dart:async';

import 'package:flutter/material.dart';

import '../model/player_gender.dart';
import '../model/quiz.dart';
import '../model/quiz_question.dart';
import '../repository/quiz_repository.dart';
import '../service/quiz_score_calculator.dart';
import 'quiz_score_view.dart';

class QuizGameView extends StatefulWidget {
  final String playerName;
  final int quizId;
  final PlayerGender gender;

  const QuizGameView({
    super.key,
    required this.playerName,
    required this.quizId,
    required this.gender,
  });

  @override
  State<QuizGameView> createState() => _QuizGameViewState();
}

class _QuizGameViewState extends State<QuizGameView> {
  static const int _maxSecondsByQuestion = 15;

  final QuizRepository _repository = QuizRepository();
  final QuizScoreCalculator _scoreCalculator = QuizScoreCalculator();

  late Future<Quiz> _futureQuiz;
  Timer? _timer;

  int _questionIndex = 0;
  int _score = 0;
  int _correctAnswers = 0;
  int _secondsLeft = _maxSecondsByQuestion;
  List<String> _currentPropositions = [];

  @override
  void initState() {
    super.initState();
    _futureQuiz = _repository.getQuiz(widget.quizId);
  }

  void _startQuestion(QuizQuestion question) {
    _timer?.cancel();
    _secondsLeft = _maxSecondsByQuestion;
    _currentPropositions = question.propositions();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        _secondsLeft--;
      });

      if (_secondsLeft <= 0) {
        _answerQuestion(question, null);
      }
    });
  }

  void _answerQuestion(QuizQuestion question, String? answer) {
    _timer?.cancel();

    final isCorrect = answer == question.reponse;
    if (isCorrect) {
      _correctAnswers++;
    }

    _score += _scoreCalculator.calculateQuestionScore(
      isCorrect: isCorrect,
      secondsLeft: _secondsLeft,
    );

    setState(() {
      _questionIndex++;
      _currentPropositions = [];
    });
  }

  void _finishQuiz(Quiz quiz) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScoreView(
            playerName: widget.playerName,
            gender: widget.gender,
            quizId: quiz.quizId,
            quizTitle: quiz.quiz,
            score: _score,
            correctAnswers: _correctAnswers,
            totalQuestions: quiz.questions.length,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Quiz>(
      future: _futureQuiz,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('Impossible de charger le quiz')),
          );
        }

        final quiz = snapshot.data!;

        if (_questionIndex >= quiz.questions.length) {
          _finishQuiz(quiz);
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final question = quiz.questions[_questionIndex];

        if (_currentPropositions.isEmpty) {
          _startQuestion(question);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(quiz.quiz),
            backgroundColor: const Color(0xFF7B2CBF),
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: (_questionIndex + 1) / quiz.questions.length,
                ),
                const SizedBox(height: 12),
                Text(
                  'Question ${_questionIndex + 1}/${quiz.questions.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  question.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 34,
                  backgroundColor: _secondsLeft <= 5
                      ? Colors.red
                      : const Color(0xFF7B2CBF),
                  child: Text(
                    '$_secondsLeft',
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                ..._currentPropositions.map(
                  (proposition) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FilledButton(
                      onPressed: () => _answerQuestion(question, proposition),
                      child: Text(proposition),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}