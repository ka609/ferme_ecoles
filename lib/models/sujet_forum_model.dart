class SujetForum {
  // Sujet forum
  final int id;

  final int auteur;

  final String? auteurNom;

  final String titre;

  final String contenu;

  final bool epingle;

  final bool ferme;

  final int nombreReponses;

  final DateTime? date;


  SujetForum({
    required this.id,
    required this.auteur,
    this.auteurNom,
    required this.titre,
    required this.contenu,
    required this.epingle,
    required this.ferme,
    required this.nombreReponses,
    this.date,
  });


  factory SujetForum.fromJson(
    Map<String, dynamic> json,
  ) {
    return SujetForum(
      id: json["id"],
      auteur: json["auteur"],
      auteurNom: json["auteur_nom"],
      titre: json["titre"] ?? "",
      contenu: json["contenu"] ?? "",
      epingle: json["epingle"] ?? false,
      ferme: json["ferme"] ?? false,
      nombreReponses:
          json["nombre_reponses"] ?? 0,
      date: json["date"] != null
          ? DateTime.parse(json["date"])
          : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "titre": titre,
      "contenu": contenu,
    };
  }
}