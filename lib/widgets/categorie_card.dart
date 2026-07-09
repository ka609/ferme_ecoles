import 'package:flutter/material.dart';

import '../models/categorie_model.dart';

class CategorieCard extends StatelessWidget {
  final Categorie categorie;
  final VoidCallback? onTap;

  const CategorieCard({
    super.key,
    required this.categorie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),

      onTap: onTap,

      child: Container(
        width: 110,

        margin: const EdgeInsets.only(
          right: 12,
        ),

        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          border: Border.all(
            color: Colors.grey.shade300,
          ),

          color: Colors.white,
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.category,
              size: 30,
            ),


            const SizedBox(height: 8),


            Text(
              categorie.nom,

              maxLines: 1,

              overflow:
                  TextOverflow.ellipsis,

              textAlign:
                  TextAlign.center,

              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}