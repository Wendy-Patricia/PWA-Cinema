import 'package:acteurs/model/film.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:acteurs/service/film_service.dart';

void main() {
  group("Classe film", () {
    test('Convertion JSON', () {
      String sr = '''{
    "film_id": 5,
    "titre": "Groom Service",
    "titre_original": "Four Rooms",
    "annee": 1995,
    "sortie": "1995-12-09",
    "duree": 98,
    "serie_id": null,
    "slogan": null,
    "pays": [
      "us"
    ],
    "created_at": "2026-05-12T09:26:57+02:00",
    "updated_at": null
  }
''';

      Film result = Film.fromRawJson(sr);
      Film origine = Film(
        filmId: 5,
        titre: "Groom Service",
        titreOriginal: "Four Rooms",
        annee: 1995,
        sortie: DateTime.parse("1995-12-09"),
        duree: 98,
        serieId: null,
        slogan: null,
        pays: ["us"],
        createdAt: DateTime.parse("2026-05-12T09:26:57+02:00"),
        updatedAt: null,
      );

      expect(result, origine); //operateur == de la classe Role
    });

    test('Appel API', () async {
      final result = await fetchFilms(11);

      expect(result, isNotEmpty);
      expect(result.length, 1);
      expect(result[0].titre, "Hero");

      // final acteur2 = await fetchFilms(1);

      // expect(result, isNotEmpty);
      // expect(acteur2.length, 3);
      // expect(acteur2[2].titre, "Cours, Lola, cours");
    });
  });
}
