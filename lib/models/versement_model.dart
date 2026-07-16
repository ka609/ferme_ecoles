class Versement {


  final int id;

  final int producteur;

  final String? producteurNom;

  final int commande;

  final String? commandeNumero;

  final double montant;

  final double commissionPlateforme;

  final double montantNet;

  final String statut;

  final DateTime? date;

  final DateTime? dateVersement;



  Versement({

    required this.id,

    required this.producteur,

    this.producteurNom,

    required this.commande,

    this.commandeNumero,

    required this.montant,

    required this.commissionPlateforme,

    required this.montantNet,

    required this.statut,

    this.date,

    this.dateVersement,

  });





  factory Versement.fromJson(
    Map<String, dynamic> json,
  ){

    return Versement(

      id:
          json["id"] ?? 0,



      producteur:
          json["producteur"] ?? 0,



      producteurNom:
          json["producteur_nom"],



      commande:
          json["commande"] ?? 0,



      commandeNumero:
          json["commande_numero"],



      montant:
          double.tryParse(
            json["montant"]?.toString() ?? "0",
          ) ??
          0,



      commissionPlateforme:
          double.tryParse(
            json["commission_plateforme"]?.toString() ?? "0",
          ) ??
          0,



      montantNet:
          double.tryParse(
            json["montant_net"]?.toString() ?? "0",
          ) ??
          0,



      statut:
          json["statut"] ?? "",



      date:
          json["date"] != null
              ? DateTime.tryParse(
                  json["date"],
                )
              : null,



      dateVersement:
          json["date_versement"] != null
              ? DateTime.tryParse(
                  json["date_versement"],
                )
              : null,

    );

  }





  Map<String,dynamic> toJson(){

    return {

      "producteur": producteur,

      "commande": commande,

      "montant": montant,

      "statut": statut,

    };

  }


}