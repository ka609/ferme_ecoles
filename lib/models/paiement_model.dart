class Paiement {

  final int id;

  final int commande;

  final String? commandeNumero;

  final double montant;

  final String moyen;

  final String? reference;

  final String statut;

  final DateTime? datePaiement;

  final DateTime? dateCreation;


  Paiement({

    required this.id,

    required this.commande,

    this.commandeNumero,

    required this.montant,

    required this.moyen,

    this.reference,

    required this.statut,

    this.datePaiement,

    this.dateCreation,

  });



  factory Paiement.fromJson(
    Map<String, dynamic> json,
  ) {

    return Paiement(

      id: json["id"] ?? 0,


      commande:
          json["commande"] ?? 0,


      commandeNumero:
          json["commande_numero"],



      montant:
          double.tryParse(
            json["montant"]?.toString() ?? "0",
          ) ??
          0,



      moyen:
          json["moyen"] ?? "",



      reference:
          json["reference"],



      statut:
          json["statut"] ?? "",



      datePaiement:
          json["date_paiement"] != null
              ? DateTime.tryParse(
                  json["date_paiement"],
                )
              : null,



      dateCreation:
          json["date_creation"] != null
              ? DateTime.tryParse(
                  json["date_creation"],
                )
              : null,

    );

  }



  Map<String, dynamic> toJson(){

    return {

      "commande": commande,

      "montant": montant,

      "moyen": moyen,

      "reference": reference,

    };

  }

}