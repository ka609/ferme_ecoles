import 'user_enum.dart';


class Utilisateur {

  final int id;

  final String username;

  final String? email;

  final String? nom;

  final String? prenom;

  final String? telephone;

  final UserRole role;

  final TypeClient? typeClient;

  final String? autrePrecision;

  final String? photo;

  final String? adresse;

  final bool actif;

  final bool premiereConnexion;

  final DateTime? dateCreation;



  Utilisateur({

    required this.id,

    required this.username,

    this.email,

    this.nom,

    this.prenom,

    this.telephone,

    required this.role,

    this.typeClient,

    this.autrePrecision,

    this.photo,

    this.adresse,

    this.actif = true,

    this.premiereConnexion = false,

    this.dateCreation,

  });



  String get nomComplet {

    return "${prenom ?? ""} ${nom ?? ""}".trim();

  }



  factory Utilisateur.fromJson(
    Map<String, dynamic> json
  ){

    return Utilisateur(

      id: json["id"],

      username:
          json["username"] ?? "",


      email:
          json["email"],


      nom:
          json["nom"],


      prenom:
          json["prenom"],


      telephone:
          json["telephone"],


      role:
          _parseRole(
            json["role"]
          ),


      typeClient:
          _parseTypeClient(
            json["type_client"]
          ),


      autrePrecision:
          json["autre_precision"],


      photo:
          json["photo"],


      adresse:
          json["adresse"],


      actif:
          json["actif"] ?? true,


      premiereConnexion:
          json["premiere_connexion"] ?? false,


      dateCreation:
          json["date_creation"] != null
          ? DateTime.parse(
              json["date_creation"]
            )
          : null,

    );

  }



  static UserRole _parseRole(
    String? value
  ){

    switch(value){

      case "PRODUCTEUR":
        return UserRole.producteur;


      case "LIVREUR":
        return UserRole.livreur;


      case "ADMIN":
        return UserRole.admin;


      default:
        return UserRole.client;
    }

  }



  static TypeClient? _parseTypeClient(
    String? value
  ){

    switch(value){

      case "RESTAURANT":
        return TypeClient.restaurant;


      case "REVENDEUR":
        return TypeClient.revendeur;


      case "AUTRE":
        return TypeClient.autre;


      default:
        return null;

    }

  }

}