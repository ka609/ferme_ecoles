class SujetForum {

  final int id;

  final int auteur;

  final String? auteurNom;

  final String titre;

  final String contenu;

  final bool epingle;

  final bool ferme;

  final int nombreReponses;

  final DateTime? date;



  SujetForum({

    required this.id,

    required this.auteur,

    this.auteurNom,

    required this.titre,

    required this.contenu,

    required this.epingle,

    required this.ferme,

    required this.nombreReponses,

    this.date,

  });





  factory SujetForum.fromJson(

    Map<String, dynamic> json,

  ) {

    return SujetForum(

      id: json["id"] ?? 0,

      auteur: json["auteur"] ?? 0,

      auteurNom: json["auteur_nom"],

      titre: json["titre"] ?? "",

      contenu: json["contenu"] ?? "",

      epingle: json["epingle"] ?? false,

      ferme: json["ferme"] ?? false,

      nombreReponses:
          json["nombre_reponses"] ?? 0,

      date: json["date"] != null

          ? DateTime.tryParse(
              json["date"].toString(),
            )

          : null,

    );

  }





  Map<String, dynamic> toJson() {

    return {

      "id": id,

      "auteur": auteur,

      "titre": titre,

      "contenu": contenu,

      "epingle": epingle,

      "ferme": ferme,

      "nombre_reponses": nombreReponses,

      "date": date?.toIso8601String(),

    };

  }





  SujetForum copyWith({

    int? id,

    int? auteur,

    String? auteurNom,

    String? titre,

    String? contenu,

    bool? epingle,

    bool? ferme,

    int? nombreReponses,

    DateTime? date,

  }) {

    return SujetForum(

      id: id ?? this.id,

      auteur: auteur ?? this.auteur,

      auteurNom: auteurNom ?? this.auteurNom,

      titre: titre ?? this.titre,

      contenu: contenu ?? this.contenu,

      epingle: epingle ?? this.epingle,

      ferme: ferme ?? this.ferme,

      nombreReponses:
          nombreReponses ?? this.nombreReponses,

      date: date ?? this.date,

    );

  }

}