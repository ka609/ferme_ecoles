class SocieteLivraison {
  // Societe livraison
  final int id;

  final String nom;

  final String? responsable;

  final String telephone;

  final String? email;

  final String? adresse;

  final bool actif;


  SocieteLivraison({
    required this.id,
    required this.nom,
    this.responsable,
    required this.telephone,
    this.email,
    this.adresse,
    required this.actif,
  });


  factory SocieteLivraison.fromJson(
    Map<String, dynamic> json,
  ) {
    return SocieteLivraison(
      id: json["id"],

      nom:
          json["nom"] ?? "",

      responsable:
          json["responsable"],

      telephone:
          json["telephone"] ?? "",

      email:
          json["email"],

      adresse:
          json["adresse"],

      actif:
          json["actif"] ?? true,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "nom": nom,
      "responsable": responsable,
      "telephone": telephone,
      "email": email,
      "adresse": adresse,
      "actif": actif,
    };
  }
}