import 'package:http/http.dart' as http;
import '../model/acteur.dart';
import 'dart:convert'; //pour utiliser jsonDecode

Future<List<Acteur>> fetchActeurs() async {
  final response = await http.get(Uri.parse('https://api.neotech.fr/acteurs'));

  if (response.statusCode == 200) {
    final List tableau = jsonDecode(response.body) as List;
    return tableau.map((e) => Acteur.fromJson(e)).toList();
    //map chaque ele e de mon tableau est convert en acteur
  } else {
    return [];
  }
}
