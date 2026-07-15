import 'package:flutter/material.dart';
import '../../models/commande_model.dart';
import 'common/status_badge.dart';


class CommandeCard extends StatelessWidget {
  final Commande commande;
  final VoidCallback? onTap;
  const CommandeCard({
    super.key,
    required this.commande,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ExpansionTile(
        onExpansionChanged: (_) => onTap?.call(),
        title: Text(
          "Commande #${commande.numero}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          commande.dateCommande != null
              ? "${commande.dateCommande!.day.toString().padLeft(2, '0')}/"
                  "${commande.dateCommande!.month.toString().padLeft(2, '0')}/"
                  "${commande.dateCommande!.year}"
              : "Date indisponible",
        ),
        trailing: StatusBadge(statut: commande.statut),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (commande.clientNom != null)
                  Text(
                    "Client : ${commande.clientNom}",
                  ),
                if (commande.producteurNom != null)
                  Text(
                    "Producteur : ${commande.producteurNom}",
                  ),
                const SizedBox(height: 8),
                Text(
                  "Adresse : ${commande.adresseLivraison}",
                ),
                const Divider(height: 24),
                const Text(
                  "Produits",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...commande.lignes.map(
                  (ligne) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      ligne.produitNom ?? "Produit",
                    ),
                    subtitle: Text(
                      "${ligne.quantite} × ${ligne.prix.toStringAsFixed(0)} FCFA",
                    ),
                    trailing: Text(
                      "${ligne.sousTotal.toStringAsFixed(0)} FCFA",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Total : ${commande.montantTotal.toStringAsFixed(0)} FCFA",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Color (String statut) {
    switch (statut.toUpperCase()) {
      case "LIVREE":
        return Colors.green.shade100;
      case "EN_COURS":
        return Colors.blue.shade100;
      case "EN_ATTENTE":
        return Colors.orange.shade100;
      case "ANNULEE":
        return Colors.red.shade100;
      default:
        return Colors.grey.shade300;
    }
  }
}   