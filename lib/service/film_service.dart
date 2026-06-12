import 'package:http/http.dart' as http;
import '../model/film.dart';
import 'dart:convert';

Future<List<Film>> fetchFilms(int filmId) async {
  final response = await http.get(Uri.parse('https://api.neotech.fr/films?film_id=eq.$filmId'));

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body) as List;
    return [Film.fromJson(data[0])];
  } else {
    throw Exception('Erreur API');
  }
}