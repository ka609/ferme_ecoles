import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/catalog_provider.dart';
import '../../providers/categorie_provider.dart';
import '../../providers/auth_provider.dart';
import '../../core/routes/app_routes.dart';

import '../../models/produit_model.dart';

import '../../widgets/produit_card.dart';
import '../../widgets/categorie_card.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/app_card.dart';
import '../../providers/panier_article_provider.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatalogProvider>().fetchProduits();
      context.read<CategorieProvider>().fetchCategories();
    });
  }

  List<Produit> _filteredProduits(List<Produit> produits) {
    if (_searchQuery.isEmpty) return produits;
    final query = _searchQuery.toLowerCase();
    return produits.where((p) => p.nom.toLowerCase().contains(query)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLogged = context.watch<AuthProvider>().isAuthenticated;

    return Scaffold(
      appBar: AppBar(
        title: const Text("FERME-ÉCOLE"),
        actions: [
          if (isLogged) ...[
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () => context.push(AppRoutes.notifications),
            ),
            IconButton(
              icon: const Icon(Icons.forum_outlined),
              onPressed: () => context.push(AppRoutes.forum),
            ),
          ] else
            TextButton(
              onPressed: () => context.push(AppRoutes.login),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text("Se connecter"),
            ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => context.push(AppRoutes.panier),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<CatalogProvider>().fetchProduits();
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              if (!isLogged)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: AppCard(
                      onTap: () => context.push(AppRoutes.login),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary.withOpacity(0.12),
                            child: Icon(
                              Icons.person_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Connectez-vous", style: Theme.of(context).textTheme.titleMedium),
                                Text(
                                  "Suivez vos commandes et vos livraisons",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                ),

              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: TextField(
                    onChanged: (query) => setState(() => _searchQuery = query),
                    decoration: const InputDecoration(
                      hintText: "Rechercher un produit",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Consumer<CategorieProvider>(
                    builder: (context, provider, child) {
                      if (provider.categories.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return SizedBox(
                        height: 90,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.categories.length,
                          itemBuilder: (context, index) {
                            return CategorieCard(categorie: provider.categories[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),

              Consumer<CatalogProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final produits = _filteredProduits(provider.produits);

                  if (produits.isEmpty) {
                    return SliverToBoxAdapter(
                      child: EmptyState(
                        icon: _searchQuery.isEmpty ? Icons.inventory_2_outlined : Icons.search_off,
                        message: _searchQuery.isEmpty
                            ? "Aucun produit disponible pour le moment"
                            : "Aucun produit ne correspond à votre recherche",
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final Produit produit = produits[index];

                          return ProduitCard(

  produit: produit,


  onTap: () {

    context.push(
      "${AppRoutes.produit}/${produit.id}",
      extra: produit,
    );

  },


  onAddCart: () async {


    final success =
        await context
            .read<PanierArticleProvider>()
            .ajouterArticle(

              produitId: produit.id,

              quantite: 1,

            );



    if(!context.mounted) return;



    ScaffoldMessenger.of(context)
        .showSnackBar(

          SnackBar(

            content: Text(

              success

              ? "${produit.nom} ajouté au panier"

              : "Erreur lors de l'ajout",

            ),

          ),

        );


  },



  onReview: () {

    context.push(
      AppRoutes.avisProduit,
      extra: produit,
    );

  },

);
                        },
                        childCount: produits.length,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.70,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}