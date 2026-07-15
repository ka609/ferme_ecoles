import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/routes/app_routes.dart';

import '../../providers/produit_provider.dart';
import '../../providers/statistique_provider.dart';
import '../../widgets/produit_card.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/common/empty_state.dart';

class ProducteurDashboard extends StatefulWidget {
  const ProducteurDashboard({super.key});

  @override
  State<ProducteurDashboard> createState() => _ProducteurDashboardState();
}

class _ProducteurDashboardState extends State<ProducteurDashboard> {
  final _produitsKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProduitProvider>().fetchMesProduits();
      context.read<StatistiqueProvider>().fetchStatistiqueProducteur();
    });
  }

  Future<void> _confirmerSuppression(int id, String nom) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Supprimer le produit ?"),
        content: Text('Voulez-vous vraiment supprimer "$nom" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final success = await context.read<ProduitProvider>().deleteProduit(id);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? "Produit supprimé" : "Erreur suppression")),
    );
  }

  Future<void> _refresh() async {
    await context.read<ProduitProvider>().fetchMesProduits();
    await context.read<StatistiqueProvider>().fetchStatistiqueProducteur();
  }

  void _scrollToProduits() {
    final ctx = _produitsKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 300));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Espace producteur"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push(AppRoutes.notifications),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push(AppRoutes.profile),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.producteurAjouterProduit),
        icon: const Icon(Icons.add),
        label: const Text("Ajouter"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Statistiques ----
              Text("Résumé activité", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),

              Consumer<StatistiqueProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final stats = provider.statistique;
                  if (stats == null) return const SizedBox.shrink();

                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      StatCard(
                        icon: Icons.inventory_2_outlined,
                        value: "${stats.nombreProduits}",
                        label: "Produits",
                        onTap: _scrollToProduits,
                      ),
                      StatCard(
                        icon: Icons.shopping_cart_outlined,
                        value: "${stats.nombreCommandes}",
                        label: "Commandes reçues",
                      ),
                      StatCard(
                        icon: Icons.check_circle_outline,
                        value: "${stats.produitsDisponibles}",
                        label: "Produits disponibles",
                        onTap: _scrollToProduits,
                      ),
                      StatCard(
                        icon: Icons.scale_outlined,
                        value: stats.stockTotal.toStringAsFixed(0),
                        label: "Stock total",
                        onTap: () => context.push(AppRoutes.statistiques),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // ---- Navigation rapide ----
              Text("Gestion", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              _NavTile(
                icon: Icons.storefront_outlined,
                title: "Voir le catalogue",
                subtitle: "Produits populaires du marché",
                onTap: () => context.push(AppRoutes.catalogue),
              ),
              _NavTile(
                icon: Icons.forum_outlined,
                title: "Forum",
                subtitle: "Échanger avec la communauté",
                onTap: () => context.push(AppRoutes.forum),
              ),
              _NavTile(
                icon: Icons.verified_outlined,
                title: "Certification BIO SPG",
                onTap: () => context.push(AppRoutes.certification),
              ),
              _NavTile(
                icon: Icons.bar_chart_outlined,
                title: "Statistiques détaillées",
                onTap: () => context.push(AppRoutes.statistiques),
              ),
              _NavTile(
                icon: Icons.receipt_long_outlined,
                title: "Commandes reçues",
                subtitle: "Commandes en cours et livrées",
                onTap: () => context.push(AppRoutes.producteurCommandes),
           ),
              _NavTile(
                icon: Icons.school_outlined,
                title: "Formations",
                subtitle: "Consulter les formations disponibles",
                onTap: () => context.push(
                        AppRoutes.formationsProducteur,
                   ),
            ),

              const SizedBox(height: 24),

              // ---- Mes produits ----
              Row(
                key: _produitsKey,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mes produits", style: Theme.of(context).textTheme.titleMedium),
                  TextButton(
                    onPressed: () => context.push(AppRoutes.producteurProduits),
                    child: const Text("Voir tout"),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Consumer<ProduitProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.mesProduits.isEmpty) {
                    return const EmptyState(
                      icon: Icons.inventory_2_outlined,
                      message: "Vous n'avez encore ajouté aucun produit",
                    );
                  }

                  final apercu = provider.mesProduits.take(5).toList();

                  return Column(
                    children: apercu.map((produit) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ProduitCard(
                          produit: produit,
                          onTap: () => context.push(
                            AppRoutes.producteurModifierProduit.replaceFirst(':id', produit.id.toString()),
                            extra: produit,
                          ),
                          actions: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => context.push(
                                AppRoutes.producteurModifierProduit.replaceFirst(':id', produit.id.toString()),
                                extra: produit,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => _confirmerSuppression(produit.id, produit.nom),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _NavTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}