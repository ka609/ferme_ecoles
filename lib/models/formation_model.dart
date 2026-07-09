class Formation {
  // Formation model
  final int id;

  final String titre;

  final String description;

  final String? document;

  final String? video;

  final int publiePar;

  final String? auteurNom;

  final DateTime? date;


  Formation({
    required this.id,
    required this.titre,
    required this.description,
    this.document,
    this.video,
    required this.publiePar,
    this.auteurNom,
    this.date,
  });


  factory Formation.fromJson(
    Map<String, dynamic> json,
  ) {
    return Formation(
      id: json["id"],
      titre: json["titre"] ?? "",
      description: json["description"] ?? "",
      document: json["document"],
      video: json["video"],
      publiePar: json["publie_par"],
      auteurNom: json["auteur_nom"],
      date: json["date"] != null
          ? DateTime.parse(json["date"])
          : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "titre": titre,
      "description": description,
      "document": document,
      "video": video,
    };
  }
}