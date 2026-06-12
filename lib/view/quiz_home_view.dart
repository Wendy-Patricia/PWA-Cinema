import 'package:flutter/material.dart';

import '../model/player_gender.dart';
import '../service/quiz_progress_service.dart';
import 'quiz_selection_view.dart';

class QuizHomeView extends StatefulWidget {
  const QuizHomeView({super.key});

  @override
  State<QuizHomeView> createState() => _QuizHomeViewState();
}

class _QuizHomeViewState extends State<QuizHomeView> {
  final TextEditingController _nameController = TextEditingController();
  final QuizProgressService _progressService = QuizProgressService();

  PlayerGender _gender = PlayerGender.homme;

  @override
  void initState() {
    super.initState();
    _loadPlayerName();
  }

  Future<void> _loadPlayerName() async {
    final name = await _progressService.getPlayerName();
    if (name != null && mounted) {
      _nameController.text = name;
    }
  }

  Future<void> _startQuiz() async {
    final playerName = _nameController.text.trim();

    if (playerName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Entrez votre nom pour commencer')),
      );
      return;
    }

    await _progressService.savePlayerName(playerName);

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QuizSelectionView(playerName: playerName, gender: _gender),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz cinéma'),
        backgroundColor: const Color(0xFF7B2CBF),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.quiz, size: 90, color: Color(0xFF7B2CBF)),
            const SizedBox(height: 24),
            const Text(
              'Bienvenue dans le quiz cinéma',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Votre nom',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _startQuiz(),
            ),
            const SizedBox(height: 16),
            SegmentedButton<PlayerGender>(
              segments: const [
                ButtonSegment<PlayerGender>(
                  value: PlayerGender.homme,
                  label: Text('Homme'),
                  icon: Icon(Icons.man),
                ),
                ButtonSegment<PlayerGender>(
                  value: PlayerGender.femme,
                  label: Text('Femme'),
                  icon: Icon(Icons.woman),
                ),
              ],
              selected: {_gender},
              onSelectionChanged: (selection) {
                setState(() {
                  _gender = selection.first;
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _startQuiz,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Commencer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
