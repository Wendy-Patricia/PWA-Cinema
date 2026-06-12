import 'package:acteurs/model/quiz.dart';
import 'package:flutter/material.dart';
import 'package:acteurs/repository/quiz_repository.dart';
import 'package:custom_cached_image/custom_cached_image.dart';

// lien img : https://img.neotech.fr/cgi/images/tr:quality=50/cinema%2fprofiles%2f2.jpg

//classe d Ã©tat pour gÃ©rer les donnÃ©es qui vont changer
class QuizView extends StatefulWidget {
  const QuizView({super.key, required this.quizId, required this.nom});

  final String nom;
  final int quizId;

  @override
  State<QuizView> createState() => _QuizViewState();
}

//et un classe du widget
//le build est obligatoire
// _ underscore indique que la classe est privÃ©e
class _QuizViewState extends State<QuizView> {
  late Future<Quiz> _futureQuizView;
  final QuizRepository _repository = QuizRepository();

  @override
  void initState() {
    super.initState();
    _futureQuizView = _repository.getQuiz(
      widget.quizId,
    ); //on affiche la liste des Quizs dans la console
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
