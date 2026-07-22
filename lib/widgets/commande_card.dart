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
        horizontal: 12,
        vertical: 8,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        childrenPadding: EdgeInsets.zero,
        onExpansionChanged: (_) {
          onTap?.call();
        },
        title: Text(
          "Commande #${commande.numero}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          commande.dateCommande != null
              ? "${commande.dateCommande!.day.toString().padLeft(2, '0')}/"
                  "${commande.dateCommande!.month.toString().padLeft(2, '0')}/"
                  "${commande.dateCommande!.year}"
              : "Date indisponible",
        ),
        trailing: StatusBadge(
          statut: commande.statut,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (commande.clientNom != null)
                  _info(
                    Icons.person_outline,
                    "Client : ${commande.clientNom}",
                  ),
                if (commande.producteurNom != null)
                  _info(
                    Icons.storefront_outlined,
                    "Producteur : ${commande.producteurNom}",
                  ),
                _info(
                  Icons.location_on_outlined,
                  "Adresse : ${commande.adresseLivraison}",
                ),
                const SizedBox(height: 12),
                const Divider(),
                const Text(
                  "Produits",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...commande.lignes.map(
                  (ligne) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              ligne.produitNom ?? "Produit",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "${ligne.quantite} x "
                            "${ligne.prix.toStringAsFixed(0)} FCFA",
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Total : "
                    "${commande.montantTotal.toStringAsFixed(0)} FCFA",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

  Widget _info(
    IconData icon,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
