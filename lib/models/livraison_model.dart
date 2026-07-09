class Livraison {
  // Livraison model
  final int id;

  final int commande;

  final String? commandeNumero;

  final int? livreur;

  final String? livreurNom;

  final int? societe;

  final String statut;

  final DateTime? datePrise;

  final DateTime? dateLivraison;

  final int? confirmeePar;

  final DateTime? dateConfirmation;


  Livraison({
    required this.id,
    required this.commande,
    this.commandeNumero,
    this.livreur,
    this.livreurNom,
    this.societe,
    required this.statut,
    this.datePrise,
    this.dateLivraison,
    this.confirmeePar,
    this.dateConfirmation,
  });


  factory Livraison.fromJson(
    Map<String, dynamic> json,
  ) {
    return Livraison(
      id: json["id"],

      commande:
          json["commande"],

      commandeNumero:
          json["commande_numero"],

      livreur:
          json["livreur"],

      livreurNom:
          json["livreur_nom"],

      societe:
          json["societe"],

      statut:
          json["statut"] ?? "",

      datePrise:
          json["date_prise"] != null
              ? DateTime.parse(
                  json["date_prise"],
                )
              : null,

      dateLivraison:
          json["date_livraison"] != null
              ? DateTime.parse(
                  json["date_livraison"],
                )
              : null,

      confirmeePar:
          json["confirmee_par"],

      dateConfirmation:
          json["date_confirmation"] != null
              ? DateTime.parse(
                  json["date_confirmation"],
                )
              : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "commande": commande,
      "livreur": livreur,
      "societe": societe,
      "statut": statut,
    };
  }
}