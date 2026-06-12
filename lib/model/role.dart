import 'dart:convert';

import 'package:flutter/foundation.dart';

class Role {
    String alias;
    String role;
    int annee;
    int duree;
    String titre;
    double? votes;
    List<String> genres;
    int filmId;

    Role({
        required this.alias,
        required this.role,
        required this.annee,
        required this.duree,
        required this.titre,
        this.votes,
        required this.genres,
        required this.filmId,
    });

    factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        alias: json["alias"] as String,
        role: json["role"] as String,
        annee: json["films"]["annee"] as int,
        duree: json["films"]["duree"] as int,
        titre: json["films"]["titre"] as String,
        votes: json["films"]["votes"] != null ? json["films"]["votes"]["moyenne"] as double : 0.0,
        genres: List<String>.from(json["films"]["genres"].map((x) => x["genre"] as String)),
        filmId: json["films"]["film_id"] as int,
    );

    @override
    int get hashCode => Object.hash(filmId, alias, role, titre, annee);

    @override
    bool operator ==(Object other) {
      return other is Role &&
        other.alias.toLowerCase() == alias.toLowerCase() &&
        other.titre == titre &&
        other.annee == annee &&
        (other.duree - duree).abs() < 3 && 
        other.filmId == filmId &&
        other.votes == votes &&
        other.genres.length == genres.length &&
        listEquals(other.genres, genres);
    }
}
