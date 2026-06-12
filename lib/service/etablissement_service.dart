import 'dart:convert';
import 'package:acteurs/model/etablissement.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;

Future<List<Etablissement>> fetchEtablissements(LatLngBounds bounds) async {
  final response = await http.post(
    Uri.parse('https://api.neotech.fr/rpc/etablissements_in_view'),
    body:
        '{ "min_lat": ${bounds.southWest.latitude}, "min_long": ${bounds.southWest.longitude}, "max_lat": ${bounds.northEast.latitude}, "max_long": ${bounds.northEast.longitude} }',
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final List tableau = jsonDecode(response.body);
    return tableau.map((e) => Etablissement.fromJson(e)).toList();
  } else {
    return [];
  }
}
