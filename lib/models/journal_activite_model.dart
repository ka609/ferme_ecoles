class JournalActivite {
  // Journal model
  final int id;

  final int utilisateur;

  final String? utilisateurUsername;

  final String action;

  final String objet;

  final String? adresseIp;

  final DateTime? date;


  JournalActivite({
    required this.id,
    required this.utilisateur,
    this.utilisateurUsername,
    required this.action,
    required this.objet,
    this.adresseIp,
    this.date,
  });


  factory JournalActivite.fromJson(
    Map<String, dynamic> json,
  ) {
    return JournalActivite(
      id: json["id"],

      utilisateur: json["utilisateur"],

      utilisateurUsername:
          json["utilisateur_username"],

      action: json["action"] ?? "",

      objet: json["objet"] ?? "",

      adresseIp: json["adresse_ip"],

      date: json["date"] != null
          ? DateTime.parse(json["date"])
          : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,

      "utilisateur": utilisateur,

      "action": action,

      "objet": objet,

      "adresse_ip": adresseIp,
    };
  }
}