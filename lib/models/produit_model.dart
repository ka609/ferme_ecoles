import 'produit_image_model.dart';
class Produit {
  // Produit model
  final int id;

  final int producteur;

  final String? producteurNom;

  final int categorie;

  final String? categorieNom;

  final String nom;

  final String? description;

  final double prix;

  final String unite;

  final double stock;

  final String typeProduit;

  final String? image;

  final List<ProduitImage> images;

  final bool valide;

  final int? validePar;

  final DateTime? dateValidation;

  final bool disponible;

  final DateTime? dateCreation;

  final DateTime? dateModification;


  Produit({
    required this.id,
    required this.producteur,
    this.producteurNom,
    required this.categorie,
    this.categorieNom,
    required this.nom,
    this.description,
    required this.prix,
    required this.unite,
    required this.stock,
    required this.typeProduit,
    this.image,
    required this.images,
    required this.valide,
    this.validePar,
    this.dateValidation,
    required this.disponible,
    this.dateCreation,
    this.dateModification,
  });


  factory Produit.fromJson(
    Map<String, dynamic> json,
  ) {
    return Produit(
      id: json["id"],

      producteur:
          json["producteur"],

      producteurNom:
          json["producteur_nom"],

      categorie:
          json["categorie"],

      categorieNom:
          json["categorie_nom"],

      nom:
          json["nom"] ?? "",

      description:
          json["description"],

      prix:
          double.tryParse(
            json["prix"].toString(),
          ) ??
          0,

      unite:
          json["unite"] ?? "",

      stock:
          double.tryParse(
            json["stock"].toString(),
          ) ??
          0,

      typeProduit:
          json["type_produit"] ?? "",

      image:
          json["image"],

      images:
          (json["images"] as List? ?? [])
              .map(
                (e) => ProduitImage.fromJson(e),
              )
              .toList(),

      valide:
          json["valide"] ?? false,

      validePar:
          json["valide_par"],

      dateValidation:
          json["date_validation"] != null
              ? DateTime.parse(
                  json["date_validation"],
                )
              : null,

      disponible:
          json["disponible"] ?? false,

      dateCreation:
          json["date_creation"] != null
              ? DateTime.parse(
                  json["date_creation"],
                )
              : null,

      dateModification:
          json["date_modification"] != null
              ? DateTime.parse(
                  json["date_modification"],
                )
              : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,

      "producteur": producteur,

      "categorie": categorie,

      "nom": nom,

      "description": description,

      "prix": prix,

      "unite": unite,

      "stock": stock,

      "type_produit": typeProduit,

      "image": image,

      "disponible": disponible,
    };
  }
}