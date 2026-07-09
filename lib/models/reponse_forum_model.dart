class ReponseForum {
  // Reponse forum
  final int id;

  final int sujet;

  final int auteur;

  final String? auteurNom;

  final String contenu;

  final DateTime? date;


  ReponseForum({
    required this.id,
    required this.sujet,
    required this.auteur,
    this.auteurNom,
    required this.contenu,
    this.date,
  });


  factory ReponseForum.fromJson(
    Map<String, dynamic> json,
  ) {
    return ReponseForum(
      id: json["id"],
      sujet: json["sujet"],
      auteur: json["auteur"],
      auteurNom: json["auteur_nom"],
      contenu: json["contenu"] ?? "",
      date: json["date"] != null
          ? DateTime.parse(json["date"])
          : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "sujet": sujet,
      "contenu": contenu,
    };
  }
}