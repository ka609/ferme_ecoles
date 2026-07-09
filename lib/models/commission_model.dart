class Commission {
  // Commission model
  final int id;

  final int livraison;

  final int livreur;

  final String? livreurNom;

  final double montant;

  final String statut;


  Commission({
    required this.id,
    required this.livraison,
    required this.livreur,
    this.livreurNom,
    required this.montant,
    required this.statut,
  });


  factory Commission.fromJson(
    Map<String, dynamic> json,
  ) {
    return Commission(
      id: json["id"],

      livraison:
          json["livraison"],

      livreur:
          json["livreur"],

      livreurNom:
          json["livreur_nom"],

      montant:
          double.tryParse(
            json["montant"].toString(),
          ) ??
          0,

      statut:
          json["statut"] ?? "",
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "livraison": livraison,
      "livreur": livreur,
    };
  }
}