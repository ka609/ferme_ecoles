import 'package:flutter/material.dart';

import '../models/produit_model.dart';

import 'common/app_card.dart';
import 'common/status_badge.dart';

class ProducteurProduitCard extends StatelessWidget {
  final Produit produit;

  final VoidCallback? onTap;

  final VoidCallback? onEdit;

  final VoidCallback? onDelete;

  const ProducteurProduitCard({
    super.key,
    required this.produit,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              produit.image ?? "",
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              loadingBuilder: (
                context,
                child,
                loadingProgress,
              ) {
                if (loadingProgress == null) {
                  return child;
                }

                return const SizedBox(
                  width: 90,
                  height: 90,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                    size: 36,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          // INFORMATIONS

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        produit.nom,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    StatusBadge(
                      statut: produit.disponible ? "VALIDEE" : "ANNULEE",
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  produit.categorieNom ?? "Catégorie",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 6),
                Text(
                  "${produit.prix.toStringAsFixed(0)} FCFA / ${produit.unite}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      "Stock : ${produit.stock.toStringAsFixed(0)} ${produit.unite}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: "Modifier",
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 20,
                      ),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      tooltip: "Supprimer",
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
