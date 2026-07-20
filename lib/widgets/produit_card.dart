import 'package:flutter/material.dart';

import '../../models/produit_model.dart';
import 'common/app_button.dart';
import 'common/app_card.dart';
import 'common/status_badge.dart';

class ProduitCard extends StatelessWidget {
  final Produit produit;
  final VoidCallback? onTap;
  final VoidCallback? onAddCart;
  final VoidCallback? onReview;
  final List<Widget>? actions;

  const ProduitCard({
    super.key,
    required this.produit,
    this.onTap,
    this.onAddCart,
    this.onReview,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE

          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.network(
                    produit.image ?? "",
                    fit: BoxFit.cover,
                    loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    },
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return Container(
                        color: Colors.grey.shade100,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.eco_outlined,
                          size: 45,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: StatusBadge(
                  statut: produit.disponible ? "Disponible" : "Rupture",
                ),
              ),
            ],
          ),

          // INFORMATIONS

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NOM PRODUIT

                Text(
                  produit.nom,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                // PRODUCTEUR

                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 15,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        produit.producteurNom ?? "Producteur",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // PRIX + AVIS

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "${produit.prix.toStringAsFixed(0)} FCFA",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: onReview,
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            produit.nombreAvis > 0
                                ? Icons.star
                                : Icons.star_outline,
                            size: 16,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            produit.nombreAvis > 0
                                ? "${produit.noteMoyenne.toStringAsFixed(1)} (${produit.nombreAvis})"
                                : "Avis",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // AJOUT PANIER

                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: produit.disponible && produit.stock > 0
                        ? "Ajouter"
                        : "Rupture",
                    onPressed: produit.disponible && produit.stock > 0
                        ? onAddCart
                        : null,
                  ),
                ),

                // ACTIONS SUPPLEMENTAIRES

                if (actions != null && actions!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    alignment: WrapAlignment.end,
                    children: actions!,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
