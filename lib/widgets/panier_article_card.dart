import 'package:flutter/material.dart';

import '../models/panier_article_model.dart';


class PanierArticleCard extends StatelessWidget {
  final PanierArticle article;
  final VoidCallback? onDelete;

  const PanierArticleCard({
    super.key,
    required this.article,
    this.onDelete,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          children: [

            // Image produit
            Container(
              width: 70,
              height: 70,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade200,
              ),

              child: const Icon(
                Icons.image,
              ),
            ),


            const SizedBox(width: 12),


            // Informations
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    article.produitNom ?? "Produit",

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                  const SizedBox(height: 6),


                  Text(
                    "Quantité : ${article.quantite}",
                  ),


                  const SizedBox(height: 4),


                  Text(
                    "${article.sousTotal} FCFA",

                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),


            // Suppression
            IconButton(
              onPressed: onDelete,

              icon: const Icon(
                Icons.delete_outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}