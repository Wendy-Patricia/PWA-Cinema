import 'package:acteurs/model/role.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:acteurs/service/role_service.dart';

void main() {
  group("Classe Role", () {
    test('Convertion JSON', () {
      String sr =
          '''{"alias":"Han Solo","role":"acteur","films":{"annee": 1977, "duree": 121, "titre": "La Guerre des étoiles", "votes": null, "genres": [{"genre": "Aventure", "genre_id": 12}, {"genre": "Action", "genre_id": 28}, {"genre": "Science-Fiction", "genre_id": 878}], "film_id": 11}}
''';

      Role result = Role.fromRawJson(sr);
      Role origine = Role(
        alias: "Han Solo",
        role: "acteur",
        annee: 1977,
        duree: 121,
        titre: "La Guerre des étoiles",
        votes: null,
        genres: ["Aventure", "Action", "Science-Fiction"],
        filmId: 11,
      );

      expect(result, origine); //operateur == de la classe Role

      //Propriete par propriete
      // expect(result.alias, "Han Solo");
      // expect(result.role, "acteur");
      // expect(result.titre, "La Guerre des étoiles");
      // expect(result.annee, 1977);
      // expect(result.duree, 121);
      // expect(result.votes, null);
      // expect(result.genres, ["Aventure", "Action", "Science-Fiction"]);
      // expect(result.filmId, 11);
    });
    test('Appel API', () async {
      final result = await fetchRoles(3);

      expect(result, isNotEmpty);
      expect(result.length, 29);
      expect(result[1].titre, "Apocalypse Now");

      final acteur2 = await fetchRoles(1245);

      expect(result, isNotEmpty);
      expect(acteur2.length, 3);
      expect(acteur2[2].alias, "Major Motoko Kusanagi (Mira Killian)");
      expect(acteur2[2].titre, "Ghost in the Shell");

    });
  });
}
