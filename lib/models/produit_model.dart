import 'produit_image_model.dart';
import '../core/constants/api_constants.dart';


String? buildImageUrl(String? image) {

  if (image == null || image.isEmpty) {
    return null;
  }


  if (image.startsWith("http")) {
    return image;
  }


  return "${ApiConstants.baseUrl}$image";
}





class Produit {


  final int id;


  final dynamic producteur;

  final String? producteurNom;


  final dynamic categorie;

  final String? categorieNom;


  final String nom;


  final String? description;


  final double prix;


  final String unite;


  final double noteMoyenne;


  final int nombreAvis;


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

    required this.noteMoyenne,

    required this.nombreAvis,

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

      id:
          json["id"] ?? 0,



      producteur:
          json["producteur"] ?? 0,



      producteurNom:
          json["producteur_nom"],



      categorie:
          json["categorie"] ?? 0,



      categorieNom:
          json["categorie_nom"],



      nom:
          json["nom"] ?? "",



      description:
          json["description"],



      prix:
          double.tryParse(
            json["prix"]?.toString() ?? "0",
          ) ??
          0,



      unite:
          json["unite"] ?? "",



      stock:
          double.tryParse(
            json["stock"]?.toString() ?? "0",
          ) ??
          0,



      noteMoyenne:
          double.tryParse(
            json["note_moyenne"]?.toString() ?? "0",
          ) ??
          0,



      nombreAvis:
          int.tryParse(
            json["nombre_avis"]?.toString() ?? "0",
          ) ??
          0,



      typeProduit:
          json["type_produit"] ?? "",



      image:
          buildImageUrl(
            json["image"],
          ),



      images:

          (json["images"] as List? ?? [])

              .map(

                (e) =>
                    ProduitImage.fromJson(e),

              )

              .toList(),




      valide:
          json["valide"] ?? false,



      validePar:
          json["valide_par"],




      dateValidation:

          json["date_validation"] != null

              ? DateTime.tryParse(
                  json["date_validation"],
                )

              : null,




      disponible:
          json["disponible"] ?? false,




      dateCreation:

          json["date_creation"] != null

              ? DateTime.tryParse(
                  json["date_creation"],
                )

              : null,




      dateModification:

          json["date_modification"] != null

              ? DateTime.tryParse(
                  json["date_modification"],
                )

              : null,


    );

  }









  Map<String, dynamic> toJson() {


    return {


      "id":
          id,



      "producteur":
          producteur,



      "categorie":
          categorie,



      "nom":
          nom,



      "description":
          description,



      "prix":
          prix,



      "unite":
          unite,



      "stock":
          stock,



      "type_produit":
          typeProduit,



      "image":
          image,



      "disponible":
          disponible,



      "note_moyenne":
          noteMoyenne,



      "nombre_avis":
          nombreAvis,


    };

  }


}