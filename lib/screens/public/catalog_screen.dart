import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/catalog_provider.dart';
import '../../providers/categorie_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/panier_article_provider.dart';
import '../../providers/notification_provider.dart';

import '../../core/routes/app_routes.dart';

import '../../models/produit_model.dart';

import '../../widgets/produit_card.dart';
import '../../widgets/common/empty_state.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    super.key,
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _searchQuery = "";

  int? _categorieSelectionnee;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatalogProvider>().fetchProduits();

      context.read<CategorieProvider>().fetchCategories();
    });
  }

  List<Produit> _filterProduits(
    List<Produit> produits,
  ) {
    var resultat = produits;

    // filtre catégorie

    if (_categorieSelectionnee != null) {
      resultat = resultat
          .where(
            (produit) => produit.categorieId == _categorieSelectionnee,
          )
          .toList();
    }

    // recherche

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();

      resultat = resultat
          .where(
            (produit) => produit.nom.toLowerCase().contains(query),
          )
          .toList();
    }

    return resultat;
  }

  @override
  Widget build(BuildContext context) {
    final isLogged = context.watch<AuthProvider>().isAuthenticated;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          titleSpacing: 16,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.eco_outlined,
                  size: 22,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "FERME-ÉCOLE",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            if (isLogged) ...[
              Consumer<NotificationProvider>(
                builder: (context, notificationProvider, child) {
                  final nombre =
                      notificationProvider.nombreNotificationsNonLues;

                  return Badge(
                    isLabelVisible: nombre > 0,
                    label: Text(
                      nombre.toString(),
                    ),
                    child: IconButton(
                      tooltip: "Notifications",
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.black87,
                      ),
                      onPressed: () => context.push(
                        AppRoutes.notifications,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                tooltip: "Forum",
                icon: const Icon(
                  Icons.forum_outlined,
                  color: Colors.black87,
                ),
                onPressed: () => context.push(
                  AppRoutes.forum,
                ),
              ),
            ],
            Consumer<PanierArticleProvider>(
              builder: (context, panierProvider, child) {
                return Badge(
                  label: Text(
                    panierProvider.nombreArticles.toString(),
                  ),
                  child: IconButton(
                    tooltip: "Panier",
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black87,
                    ),
                    onPressed: () => context.push(
                      AppRoutes.panier,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        // body
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await context.read<CatalogProvider>().fetchProduits();
            },
            child: CustomScrollView(slivers: [
              // =========================
// BLOC CONNEXION
// =========================
              if (!isLogged)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Connectez-vous pour commander",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Ajoutez vos produits préférés au panier et suivez vos commandes facilement.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 14),
                            SizedBox(
                              width: 160,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.push(
                                    AppRoutes.login,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Connexion",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // RECHERCHE
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                sliver: SliverToBoxAdapter(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Rechercher un produit...",
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () {
                                setState(() {
                                  _searchQuery = "";
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // CATEGORIES
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverToBoxAdapter(
                  child: Consumer<CategorieProvider>(
                    builder: (context, categorieProvider, child) {
                      return DropdownButtonFormField<int?>(
                        value: _categorieSelectionnee,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        decoration: InputDecoration(
                          labelText: "Catégorie",
                          prefixIcon: const Icon(Icons.category_outlined),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.5,
                            ),
                          ),
                        ),
                        items: [
                          const DropdownMenuItem<int?>(
                            value: null,
                            child: Text("Toutes les catégories"),
                          ),
                          ...categorieProvider.categories.map(
                            (categorie) => DropdownMenuItem<int?>(
                              value: categorie.id,
                              child: Text(categorie.nom),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _categorieSelectionnee = value;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),

              Consumer<CatalogProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 60),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }

                  final produits = _filterProduits(provider.produits);

                  if (produits.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 60),
                        child: EmptyState(
                          icon: Icons.search_off,
                          message: "Aucun produit trouvé",
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    sliver: SliverLayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.crossAxisExtent;

                        int crossAxisCount;

                        if (width >= 1200) {
                          crossAxisCount = 5;
                        } else if (width >= 900) {
                          crossAxisCount = 4;
                        } else if (width >= 650) {
                          crossAxisCount = 3;
                        } else {
                          crossAxisCount = 2;
                        }

                        return SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final produit = produits[index];

                              return ProduitCard(
                                produit: produit,
                                onTap: () {
                                  context.push(
                                    "${AppRoutes.produit}/${produit.id}",
                                    extra: produit,
                                  );
                                },
                                onAddCart: () async {
                                  final success = await context
                                      .read<PanierArticleProvider>()
                                      .ajouterArticle(
                                        produitId: produit.id,
                                        quantite: 1,
                                      );

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.50,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ]),
          ),
        ));
  }
}
