import 'package:flutter_test/flutter_test.dart';
import 'package:acteurs/model/quiz_question.dart';

void main() {
  test('propositions contient la bonne réponse et les mauvaises réponses', () {
    final question = QuizQuestion(
      question: 'Qui est Batman ?',
      reponse: 'Bruce Wayne',
      autres: ['Clark Kent', 'Peter Parker', 'Tony Stark'],
    );

    final propositions = question.propositions();

    expect(propositions, contains('Bruce Wayne'));
    expect(propositions, contains('Clark Kent'));
    expect(propositions.length, 4);
  });
}