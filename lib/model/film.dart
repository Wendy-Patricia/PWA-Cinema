import 'dart:convert';
import 'package:flutter/foundation.dart';

class Film {
  final int filmId;
  final String titre;
  final String? titreOriginal;
  final int annee;
  final DateTime sortie;
  final int duree;
  final int? serieId;
  final String? slogan;
  final List<String> pays;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Film({
    required this.filmId,
    required this.titre,
    this.titreOriginal, // optionnel (nullable)
    required this.annee,
    required this.sortie,
    required this.duree,
    this.serieId, // optionnel (nullable)
    this.slogan, // optionnel (nullable)
    required this.pays,
    required this.createdAt,
    this.updatedAt, // optionnel (nullable)
  });

  factory Film.fromRawJson(String str) => Film.fromJson(json.decode(str));

  //contructor de type factory pour contruir un acteur a partir d'un json
  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      filmId: json['film_id'] as int,
      titre: json['titre'] as String,

      // String? : peut être null
      titreOriginal: json['titre_original'] as String?,

      annee: json['annee'] as int,

      // String → DateTime
      sortie: DateTime.parse(json['sortie'] as String),

      duree: json['duree'] as int,

      // int? : peut être null
      serieId: json['serie_id'] as int?,

      slogan: json['slogan'] as String?,

      // List<dynamic> → List<String>
      pays: List<String>.from(json['pays'] as List),

      // String → DateTime (avec fuseau horaire)
      createdAt: DateTime.parse(json['created_at'] as String),

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  // TODO: implement hashCode
  @override
  int get hashCode => Object.hash(
    filmId,
    titre,
    titreOriginal,
    annee,
    sortie,
    duree,
    serieId,
    slogan,
    pays,
    createdAt,
    updatedAt,
  );

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is Film &&
        other.filmId == filmId &&
        other.titre == titre &&
        other.titreOriginal == titreOriginal &&
        other.annee == annee &&
        other.sortie == sortie &&
        other.duree == duree &&
        other.serieId == serieId &&
        other.slogan == slogan &&
        other.pays.length == pays.length &&
        listEquals(other.pays, pays) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  String toString() {
    return 'Film {filmId: $filmId, titre: $titre, titreOriginal: $titreOriginal, annee: $annee, sortie: $sortie, duree: $duree, serieId: $serieId, slogan: $slogan, pays: $pays, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
