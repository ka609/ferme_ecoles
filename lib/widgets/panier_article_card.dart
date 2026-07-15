import 'package:flutter/material.dart';
import '../../models/panier_article_model.dart';
import 'common/app_card.dart';

class PanierArticleCard extends StatelessWidget {
  final PanierArticle article;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onDelete;

  const PanierArticleCard({
    super.key,
    required this.article,
    this.onIncrement,
    this.onDecrement,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(article.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete?.call(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: AppCard(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          title: Text(article.produitNom ?? "Produit"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${article.prix.toStringAsFixed(0)} FCFA"),
              Text(
                "Sous-total : ${article.sousTotal.toStringAsFixed(0)} FCFA",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: const Icon(Icons.remove), onPressed: onDecrement),
              Text("${article.quantite}", style: const TextStyle(fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.add), onPressed: onIncrement),
            ],
          ),
        ),
      ),
    );
  }
}