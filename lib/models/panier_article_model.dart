class PanierArticle {
  // Panier article
  final int id;

  final int produit;

  final String? produitNom;

  final double quantite;

  final double prix;

  final double sousTotal;


  PanierArticle({
    required this.id,
    required this.produit,
    this.produitNom,
    required this.quantite,
    required this.prix,
    required this.sousTotal,
  });


  factory PanierArticle.fromJson(
    Map<String, dynamic> json,
  ) {
    return PanierArticle(
      id: json["id"],
      produit: json["produit"],
      produitNom: json["produit_nom"],
      quantite: double.tryParse(
            json["quantite"].toString(),
         ) ?? 0,
      prix: double.tryParse(
            json["prix"].toString(),
          ) ??
          0,
      sousTotal: double.tryParse(
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