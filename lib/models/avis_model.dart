class Avis {
  final int id;

  final int produit;

  final String? produitNom;

  final int client;

  final String? clientNom;

  final int note;

  final String commentaire;

  final DateTime? date;

  const Avis({
    required this.id,
    required this.produit,
    this.produitNom,
    required this.client,
    this.clientNom,
    required this.note,
    required this.commentaire,
    this.date,
  });

  factory Avis.fromJson(Map<String, dynamic> json) {
    return Avis(
      id: json["id"] ?? 0,

      produit: json["produit"] ?? 0,

      produitNom: json["produit_nom"],

      client: json["client"] ?? 0,

      clientNom: json["client_nom"],

      note: json["note"] ?? 0,

      commentaire: json["commentaire"] ?? "",

      date: json["date"] != null
          ? DateTime.tryParse(json["date"].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "produit": produit,
      "note": note,
      "commentaire": commentaire,
    };
  }
}