class LigneCommande {
  // Ligne commande
  final int id;

  final int produit;

  final String? produitNom;

  final int quantite;

  final double prix;

  final double sousTotal;


  LigneCommande({
    required this.id,
    required this.produit,
    this.produitNom,
    required this.quantite,
    required this.prix,
    required this.sousTotal,
  });


  factory LigneCommande.fromJson(
    Map<String, dynamic> json,
  ) {
    return LigneCommande(
      id: json["id"],
      produit: json["produit"],
      produitNom: json["produit_nom"],
      quantite: json["quantite"] ?? 0,
      prix:
          double.tryParse(
            json["prix"].toString(),
          ) ??
          0,
      sousTotal:
          double.tryParse(
            json["sous_total"].toString(),
          ) ??
          0,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "produit": produit,
      "quantite": quantite,
    };
  }
}