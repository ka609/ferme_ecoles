import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/product_model.dart';

/// Carte produit utilisée dans les grilles "Produits populaires" et
/// "Nouveautés" de l'accueil, ainsi que dans le Catalogue.
/// Reprend la logique visuelle des product-cards du template Ogani :
/// image carrée, nom, producteur, prix, bouton d'ajout rapide au panier.
class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: product.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: product.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(color: AppColors.surface),
                          errorWidget: (_, __, ___) => Container(
                            color: AppColors.surface,
                            child: const Icon(Icons.eco_outlined, color: AppColors.textSecondary),
                          ),
                        )
                      : Container(
                          color: AppColors.surface,
                          child: const Icon(Icons.eco_outlined, size: 40, color: AppColors.textSecondary),
                        ),
                ),
                if (product.isNew)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: _Badge(label: 'Nouveau', color: AppColors.primary),
                  ),
                if (!product.inStock)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _Badge(label: 'Rupture', color: AppColors.error),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.producerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      product.formattedPrice,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: product.inStock ? onAddToCart : null,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: product.inStock ? AppColors.primaryLight : AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_shopping_cart,
                        size: 16,
                        color: product.inStock ? AppColors.primary : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}