class Acteur {
  final int personneId;
  final String nom;
  final String metaphone;
  final DateTime naissance;
  final int? age;
  DateTime?
  deces; // o ? é para permitir nulo, caso o ator ainda esteja vivo se nao o valor deve ser inicializado com aµ data de falecimento
  final String nationalite;
  final String? drapeauUnicode;
  final int nbFilm;
  final double popularite;

  //Construtor
  Acteur({
    required this.personneId, //required: paramatre obligatoire car proprieté non nullable
    required this.nom,
    required this.metaphone,
    required this.naissance,
    this.age,
    this.deces,
    required this.nationalite,
    this.drapeauUnicode,
    required this.nbFilm,
    required this.popularite,
  });

  //contructor de type factory pour contruir un acteur a partir d'un json
  factory Acteur.fromJson(Map<String, dynamic> json) {
    return Acteur(
      personneId: (json['personne_id'] as int?) ?? 0, // ✅ int? primeiro
      nom: json['nom'] as String? ?? '',
      metaphone: json['metaphone'] as String? ?? '',
      naissance: DateTime.parse(json['naissance'] as String),
      age: json['age'] != null ? json['age'] as int? : null, // ✅ int? primeiro
      deces: json['deces'] != null
          ? DateTime.parse(json['deces'] as String)
          : null,
      nationalite: json['nationalite'] as String? ?? '',
      drapeauUnicode: json['drapeau_unicode'] != null ? json['drapeau_unicode'] as String? : null,
      nbFilm: (json['nb_film'] as int?) ?? 0, 
      popularite: (json['popularite'] as double?) ?? 0.0, // ✅ double? primeiro
    );
  }

  @override
  String toString() {
    return 'Acteur {personneId: $personneId, nom: $nom, metaphone: $metaphone, naissance: $naissance, age: $age, deces: $deces, nationalite: $nationalite, drapeauUnicode: $drapeauUnicode, nbFilm: $nbFilm, popularite: $popularite}';
  }
}
