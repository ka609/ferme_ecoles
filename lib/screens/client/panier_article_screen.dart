import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';
import '../../providers/panier_article_provider.dart';
import '../../providers/panier_provider.dart';
import '../../providers/commande_provider.dart';

import '../../widgets/panier_article_card.dart';
import '../../widgets/common/empty_state.dart';

class PanierArticlesScreen extends StatefulWidget {
  final int panierId;

  const PanierArticlesScreen({
    super.key,
    required this.panierId,
  });

  @override
  State<PanierArticlesScreen> createState() => _PanierArticlesScreenState();
}

class _PanierArticlesScreenState extends State<PanierArticlesScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PanierArticleProvider>().fetchArticles();

      context.read<PanierProvider>().fetchPanierDetail(
            widget.panierId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contenu du panier",
        ),
      ),
      body: Consumer2<PanierArticleProvider, PanierProvider>(
        builder: (
          context,
          articleProvider,
          panierProvider,
          child,
        ) {
          if (articleProvider.isLoading || panierProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (articleProvider.articles.isEmpty) {
            return const EmptyState(
              icon: Icons.remove_shopping_cart_outlined,
              message: "Aucun article dans ce panier",
            );
          }

          final panier = panierProvider.detail;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: articleProvider.articles.length,
                  itemBuilder: (context, index) {
                    final article = articleProvider.articles[index];

                    return PanierArticleCard(
                      article: article,
                      onDelete: () {
                        articleProvider.supprimerArticle(
                          article.id,
                        );
                      },
                      onIncrease: () {
                        articleProvider.modifierQuantite(
                          articleId: article.id,
                          quantite: article.quantite + 1,
                        );
                      },
                      onDecrease: () {
                        if (article.quantite > 1) {
                          articleProvider.modifierQuantite(
                            articleId: article.id,
                            quantite: article.quantite - 1,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${articleProvider.total.toStringAsFixed(0)} FCFA",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: panier == null
                            ? null
                            : () async {
                                if (panier.producteur == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Producteur introuvable",
                                      ),
                                    ),
                                  );

                                  return;
                                }

                                final commande = await context
                                    .read<CommandeProvider>()
                                    .createCommandeFromPanier(
                                      producteurId: panier.producteur!,
                                      adresseLivraison: "Adresse du client",
                                      lignes: articleProvider.articles
                                          .map((article) {
                                        return {
                                          "produit": article.produit,
                                          "quantite": article.quantite,
                                        };
                                      }).toList(),
                                    );
                                    print("Commande créée ID = ${commande?.id}");

                                if (commande != null && context.mounted) {
                                  context.push(
                                    AppRoutes.paiement,
                                    extra: commande,
                                  );
                                }
                              },
                        child: const Text(
                          "Passer la commande",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
