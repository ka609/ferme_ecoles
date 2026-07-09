class Certification {
  // Certification model
  final int id;

  final int producteur;

  final String? producteurNom;

  final String type;

  final String numero;

  final String? document;

  final DateTime? dateDebut;

  final DateTime? dateFin;

  final String statut;

  final int? validePar;

  final DateTime? dateValidation;

  final bool estActive;


  Certification({
    required this.id,
    required this.producteur,
    this.producteurNom,
    required this.type,
    required this.numero,
    this.document,
    this.dateDebut,
    this.dateFin,
    required this.statut,
    this.validePar,
    this.dateValidation,
    required this.estActive,
  });


  factory Certification.fromJson(
    Map<String, dynamic> json,
  ) {
    return Certification(
      id: json["id"],

      producteur: json["producteur"],

      producteurNom:
          json["producteur_nom"],

      type: json["type"] ?? "",

      numero: json["numero"] ?? "",

      document: json["document"],

      dateDebut: json["date_debut"] != null
          ? DateTime.parse(json["date_debut"])
          : null,

      dateFin: json["date_fin"] != null
          ? DateTime.parse(json["date_fin"])
          : null,

      statut: json["statut"] ?? "",

      validePar: json["valide_par"],

      dateValidation:
          json["date_validation"] != null
              ? DateTime.parse(
                  json["date_validation"],
                )
              : null,

      estActive:
          json["est_active"] ?? false,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,

      "producteur": producteur,

      "type": type,

      "numero": numero,

      "document": document,

      "date_debut":
          dateDebut?.toIso8601String(),

      "date_fin":
          dateFin?.toIso8601String(),

      "statut": statut,
    };
  }
}