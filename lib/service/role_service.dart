import 'package:http/http.dart' as http;
import '../model/role.dart';
import 'dart:convert'; //pour utiliser jsonDecode

Future<List<Role>> fetchRoles(int personneId) async {
  final response = await http.get(Uri.parse('https://api.neotech.fr/equipes?personne_id=eq.$personneId&role=eq.acteur&select=alias,role,films(film_id,%20titre,%20annee,%20duree,%20genres(*),votes(*))'));

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body) as List;
    return data.map((e) => Role.fromJson(e)).toList();
    //map chaque ele e de mon tableau est convert en role
  } else {
    throw Exception('Erreur API');
  }
}
