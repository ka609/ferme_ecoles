import 'package:flutter/material.dart';
import '../models/categorie_model.dart';
import 'common/app_card.dart';

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
    return AppCard(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.category, size: 30),
          const SizedBox(height: 8),
          Text(
            categorie.nom,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ],
      ),
    );
  }
}