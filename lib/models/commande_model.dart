import 'ligne_commande_model.dart';
class Commande {
  // Commande model
  final int id;

  final String numero;

  final int client;

  final String? clientNom;

  final int producteur;

  final String? producteurNom;

  final int? livreur;

  final String adresseLivraison;

  final double montantTotal;

  final String statut;

  final DateTime? dateCommande;

  final List<LigneCommande> lignes;


  Commande({
    required this.id,
    required this.numero,
    required this.client,
    this.clientNom,
    required this.producteur,
    this.producteurNom,
    this.livreur,
    required this.adresseLivraison,
    required this.montantTotal,
    required this.statut,
    this.dateCommande,
    required this.lignes,
  });


  factory Commande.fromJson(
    Map<String, dynamic> json,
  ) {
    return Commande(
      id: json["id"],
      numero: json["numero"] ?? "",
      client: json["client"],
      clientNom: json["client_nom"],
      producteur: json["producteur"],
      producteurNom: json["producteur_nom"],
      livreur: json["livreur"],
      adresseLivraison:
          json["adresse_livraison"] ?? "",
      montantTotal:
          double.tryParse(
            json["montant_total"].toString(),
          ) ??
          0,
      statut: json["statut"] ?? "",
      dateCommande:
          json["date_commande"] != null
              ? DateTime.parse(
                  json["date_commande"],
                )
              : null,
      lignes:
          (json["lignes"] as List? ?? [])
              .map(
                (e) => LigneCommande.fromJson(e),
              )
              .toList(),
    );
  }
}