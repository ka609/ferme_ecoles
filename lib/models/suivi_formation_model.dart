class SuiviFormation {
  // Suivi formation
  final int id;

  final int formation;

  final String? formationTitre;

  final int producteur;

  final String? producteurNom;

  final int progression;

  final bool terminee;

  final DateTime? date;


  SuiviFormation({
    required this.id,
    required this.formation,
    this.formationTitre,
    required this.producteur,
    this.producteurNom,
    required this.progression,
    required this.terminee,
    this.date,
  });


  factory SuiviFormation.fromJson(
    Map<String, dynamic> json,
  ) {
    return SuiviFormation(
      id: json["id"],

      formation: json["formation"],

      formationTitre:
          json["formation_titre"],

      producteur:
          json["producteur"],

      producteurNom:
          json["producteur_nom"],

      progression:
          json["progression"] ?? 0,

      terminee:
          json["terminee"] ?? false,

      date: json["date"] != null
          ? DateTime.parse(json["date"])
          : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "formation": formation,

      "producteur": producteur,

      "progression": progression,
    };
  }
}