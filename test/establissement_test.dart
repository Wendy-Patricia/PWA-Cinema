import 'package:acteurs/model/etablissement.dart';
import 'package:acteurs/repository/etablissement_repository.dart';
import 'package:acteurs/service/etablissement_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('Test Etablissement', () {
    test('Conversion JSON', () {
      final chaine = """
{
    "etablissement_id": 47476,
    "nom": "PATHE BELFORT",
    "ville": "Belfort",
    "voie": "1 BOULEVARD RICHELIEU",
    "codepostal": null,
    "lat": 47.63059,
    "long": 6.861946
  }
      """;

    final result = Etablissement.fromRawJson(chaine);

    expect(result.nom, "PATHE BELFORT");
    expect(result.ville, "Belfort");
    });

    test('Appel API', () async {
      final result = await fetchEtablissements(LatLngBounds(LatLng(46.5, 6.5), LatLng(47.5, 7.5)));

      expect(result, isNotEmpty);
      expect(result.length, 6);
      expect(result[1].nom, "SALLE SAINT MICHEL");

    });

    test('Repository', () async {
      final repo = EtablissementRepository();
      final result = await repo.getEtablissements(LatLngBounds(LatLng(46.5, 6.5), LatLng(47.5, 7.5)));

      expect(result[1].nom, "SALLE SAINT MICHEL");
    });
  });

  
}