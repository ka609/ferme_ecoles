import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/category_model.dart';

/// Reprend la section "Category" de l'accueil Ogani : icône dans un cercle
/// coloré + nom en dessous. Ici on utilise une icône générique par défaut
/// (eco) tant que le backend ne fournit pas d'icône par catégorie.
class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool selected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.category,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 76,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.eco,
                color: selected ? Colors.white : AppColors.primary,
                size: 26,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? AppColors.primaryDark : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}