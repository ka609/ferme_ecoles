import 'panier_article_model.dart';
class Panier {
  // Panier model
  final int id;

  final int client;

  final int? producteur;

  final String? producteurNom;

  final List<PanierArticle> articles;

  final DateTime? dateCreation;


  Panier({
    required this.id,
    required this.client,
    this.producteur,
    this.producteurNom,
    required this.articles,
    this.dateCreation,
  });


  factory Panier.fromJson(
    Map<String, dynamic> json,
  ) {
    return Panier(
      id: json["id"],
      client: json["client"],
      producteur: json["producteur"],
      producteurNom: json["producteur_nom"],
      articles:
          (json["articles"] as List? ?? [])
              .map(
                (e) => PanierArticle.fromJson(e),
              )
              .toList(),
      dateCreation:
          json["date_creation"] != null
              ? DateTime.parse(
                  json["date_creation"],
                )
              : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "client": client,
      "producteur": producteur,
    };
  }
}