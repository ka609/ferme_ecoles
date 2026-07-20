import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/routes/app_routes.dart';

import '../../providers/produit_provider.dart';
import '../../providers/statistique_provider.dart';
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

  // ---------------------------------------------------------------------
  // Logique métier : INCHANGÉE
  // ---------------------------------------------------------------------

  Future<void> _confirmerSuppression(int id, String nom) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Supprimer le produit ?"),
        content: Text('Voulez-vous vraiment supprimer "$nom" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Annuler"),
          ),
          FilledButton.tonal(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(0.1),
              foregroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final success = await context.read<ProduitProvider>().deleteProduit(id);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(success ? "Produit supprimé" : "Erreur suppression"),
      ),
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

  // ---------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 900;
    final isTablet = width >= 600 && width < 900;

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        title: const Text("Espace producteur"),
        actions: [
          IconButton(
            tooltip: "Notifications",
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push(AppRoutes.notifications),
          ),
          IconButton(
            tooltip: "Profil",
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push(AppRoutes.profile),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: isWide
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.producteurAjouterProduit),
              icon: const Icon(Icons.add),
              label: const Text("Ajouter"),
            ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 32 : 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBanner(context, isWide),
                    const SizedBox(height: 24),
                    _buildStatsSection(context, isWide, isTablet),
                    const SizedBox(height: 24),
                    // Ancre stable pour le scroll-to : reste toujours au même
                    // endroit de l'arbre, qu'on soit en layout large ou étroit,
                    // pour éviter de déplacer une GlobalKey entre deux parents
                    // différents (source des crashs de hit-test au resize).
                    KeyedSubtree(
                      key: _produitsKey,
                      child: const SizedBox.shrink(),
                    ),
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildProduitsSection(context),
                          ),
                          const SizedBox(width: 24),
                          SizedBox(
                            width: 320,
                            child: _buildGestionSection(context),
                          ),
                        ],
                      )
                    else ...[
                      _buildGestionSection(context),
                      const SizedBox(height: 24),
                      _buildProduitsSection(context),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---- Bannière d'accueil ------------------------------------------------

  Widget _buildBanner(BuildContext context, bool isWide) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 32 : 20, vertical: isWide ? 28 : 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.75),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: isWide ? 30 : 24,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(Icons.agriculture_outlined,
                color: Colors.white, size: isWide ? 32 : 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bienvenue sur votre tableau de bord",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Suivez vos produits, vos commandes et vos revenus en un coup d'œil.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                ),
              ],
            ),
          ),
          if (isWide) ...[
            const SizedBox(width: 16),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => context.push(AppRoutes.producteurAjouterProduit),
              icon: const Icon(Icons.add),
              label: const Text("Ajouter un produit"),
            ),
          ],
        ],
      ),
    );
  }

  // ---- Section générique (carte avec en-tête) ----------------------------

  Widget _sectionCard({
    required BuildContext context,
    required String title,
    IconData? icon,
    Widget? trailing,
    required Widget child,
    Key? key,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, size: 18, color: colorScheme.primary),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // ---- Statistiques -------------------------------------------------------

  Widget _buildStatsSection(BuildContext context, bool isWide, bool isTablet) {
    final crossAxisCount = isWide ? 4 : (isTablet ? 4 : 2);

    return _sectionCard(
      context: context,
      title: "Résumé activité",
      icon: Icons.insights_outlined,
      child: Consumer<StatistiqueProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final stats = provider.statistique;
          if (stats == null) return const SizedBox.shrink();

          return GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
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
    );
  }

  // ---- Gestion (menu) ------------------------------------------------------

  Widget _buildGestionSection(BuildContext context) {
    final items = <_MenuItemData>[
      _MenuItemData(
        icon: Icons.storefront_outlined,
        title: "Voir le catalogue",
        subtitle: "Produits populaires du marché",
        onTap: () => context.push(AppRoutes.catalogue),
      ),
      _MenuItemData(
        icon: Icons.forum_outlined,
        title: "Forum",
        subtitle: "Échanger avec la communauté",
        onTap: () => context.push(AppRoutes.forum),
      ),
      _MenuItemData(
        icon: Icons.verified_outlined,
        title: "Certification BIO SPG",
        onTap: () => context.push(AppRoutes.certification),
      ),
      _MenuItemData(
        icon: Icons.bar_chart_outlined,
        title: "Statistiques détaillées",
        onTap: () => context.push(AppRoutes.statistiques),
      ),
      _MenuItemData(
        icon: Icons.receipt_long_outlined,
        title: "Commandes reçues",
        subtitle: "Commandes en cours et livrées",
        onTap: () => context.push(AppRoutes.producteurCommandes),
      ),
      _MenuItemData(
        icon: Icons.school_outlined,
        title: "Formations",
        subtitle: "Consulter les formations disponibles",
        onTap: () => context.push(AppRoutes.formationsProducteur),
      ),
      _MenuItemData(
        icon: Icons.account_balance_wallet_outlined,
        title: "Versements",
        subtitle: "Consulter mes revenus",
        onTap: () => context.push(AppRoutes.versements),
      ),
    ];

    return _sectionCard(
      context: context,
      title: "Gestion",
      icon: Icons.dashboard_customize_outlined,
      child: Column(
        children: items
            .map((item) => _MenuTile(item: item))
            .toList(),
      ),
    );
  }

  // ---- Mes produits (tableau) ------------------------------------------------

  Widget _buildProduitsSection(BuildContext context) {
    return _sectionCard(
      context: context,
      title: "Produits",
      icon: Icons.spa_outlined,
      trailing: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          TextButton.icon(
            onPressed: () => context.push(AppRoutes.producteurProduits),
            icon: const Icon(Icons.arrow_forward, size: 16),
            label: const Text("Voir tout"),
          ),         
        ],
      ),
      child: Consumer<ProduitProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (provider.mesProduits.isEmpty) {
            return const EmptyState(
              icon: Icons.inventory_2_outlined,
              message: "Vous n'avez encore ajouté aucun produit",
            );
          }

          final apercu = provider.mesProduits.take(5).toList();
          final colorScheme = Theme.of(context).colorScheme;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  "${apercu.length} résultat${apercu.length > 1 ? 's' : ''}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              // Le tableau défile horizontalement sur petit écran plutôt que
              // de casser la mise en page.
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(
                    colorScheme.surfaceContainerLow,
                  ),
                  headingTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  columnSpacing: 28,
                  columns: const [
                    DataColumn(label: Text("Nom")),
                    DataColumn(label: Text("Producteur")),
                    DataColumn(label: Text("Catégorie")),
                    DataColumn(label: Text("Prix"), numeric: true),
                    DataColumn(label: Text("Stock"), numeric: true),
                    DataColumn(label: Text("Type produit")),
                    DataColumn(label: Text("Valide")),
                    DataColumn(label: Text("Disponible")),
                    DataColumn(label: Text("Date création")),
                    DataColumn(label: Text("Actions")),
                  ],
                  rows: apercu.map((produit) {
                    return DataRow(
                      onSelectChanged: (_) => context.push(
                        AppRoutes.producteurModifierProduit
                            .replaceFirst(':id', produit.id.toString()),
                        extra: produit,
                      ),
                      cells: [
                        DataCell(Text(produit.nom)),
                        // ⚠️ adapte ces accès aux vrais champs de ton modèle
                        // Produit (ex : produit.producteur.nom au lieu de
                        // produit.producteur si c'est un objet imbriqué).
                        DataCell(Text('${produit.producteur}')),
                        DataCell(Text('${produit.categorie}')),
                        DataCell(Text(_formatPrix(produit.prix))),
                        DataCell(Text('${produit.stock}')),
                        DataCell(Text('${produit.typeProduit}')),
                        DataCell(_buildBoolBadge(context, produit.valide)),
                        DataCell(_buildBoolBadge(context, produit.disponible)),
                        DataCell(Text(produit.dateCreation != null ? _formatDate(produit.dateCreation!) : "-")),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: "Modifier",
                                icon: const Icon(Icons.edit_outlined, size: 18),
                                onPressed: () => context.push(
                                  AppRoutes.producteurModifierProduit
                                      .replaceFirst(':id', produit.id.toString()),
                                  extra: produit,
                                ),
                              ),
                              IconButton(
                                tooltip: "Supprimer",
                                icon: const Icon(Icons.delete_outline,
                                    size: 18, color: Colors.red),
                                onPressed: () =>
                                    _confirmerSuppression(produit.id, produit.nom),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Badge coloré Oui/Non plutôt que le texte brut "True"/"False".
  Widget _buildBoolBadge(BuildContext context, bool value) {
    final color = value ? Colors.green : Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(value ? Icons.check_circle : Icons.cancel, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            value ? "Oui" : "Non",
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // "250000,00" — sans séparateur de milliers, virgule décimale.
  String _formatPrix(num prix) => prix.toStringAsFixed(2).replaceAll('.', ',');

  // "18 juillet 2026 09:38"
  String _formatDate(DateTime date) {
    const mois = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
    ];
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '${date.day} ${mois[date.month - 1]} ${date.year} $h:$m';
  }
}

// ---------------------------------------------------------------------------
// Widgets internes
// ---------------------------------------------------------------------------

class _MenuItemData {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  _MenuItemData({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });
}

class _MenuTile extends StatelessWidget {
  final _MenuItemData item;

  const _MenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: item.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.icon, size: 18, color: colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      if (item.subtitle != null)
                        Text(
                          item.subtitle!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 14, color: colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}