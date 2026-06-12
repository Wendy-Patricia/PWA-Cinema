import 'dart:convert';

import 'package:latlong2/latlong.dart';

class Etablissement {
    int etablissementId;
    String nom;
    String ville;
    String voie;
    LatLng point;
    
    Etablissement({
        required this.etablissementId,
        required this.nom,
        required this.ville,
        required this.voie,
        required this.point,
    });

    factory Etablissement.fromRawJson(String str) => Etablissement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Etablissement.fromJson(Map<String, dynamic> json) => Etablissement(
        etablissementId: json["etablissement_id"],
        nom: json["nom"],
        ville: json["ville"],
        voie: json["voie"],
        point: LatLng(json["lat"].toDouble(), json["long"].toDouble()),
    );

    Map<String, dynamic> toJson() => {
        "etablissement_id": etablissementId,
        "nom": nom,
        "ville": ville,
        "voie": voie,
        "lat": point.latitude,
        "long": point.longitude,
    };
}