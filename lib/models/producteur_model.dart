class Producteur {
  // Producteur model
  final int id;

  final int utilisateur;

  final String? username;

  final String? email;

  final String nomExploitation;

  final String? description;

  final DateTime? dateCreation;


  Producteur({
    required this.id,
    required this.utilisateur,
    this.username,
    this.email,
    required this.nomExploitation,
    this.description,
    this.dateCreation,
  });


  factory Producteur.fromJson(
    Map<String, dynamic> json,
  ) {
    return Producteur(
      id: json["id"],

      utilisateur: json["utilisateur"],

      username: json["username"],

      email: json["email"],

      nomExploitation:
          json["nom_exploitation"] ?? "",

      description:
          json["description"],

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
      "id": id,

      "utilisateur": utilisateur,

      "nom_exploitation":
          nomExploitation,

      "description": description,
    };
  }
}