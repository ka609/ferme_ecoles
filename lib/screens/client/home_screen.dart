import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/category_item.dart';
import '../../widgets/product_card.dart';
import '../../widgets/section_header.dart';

/// Écran "Accueil Client".
/// Adaptation directe de la home du template Ogani :
///   - Header avec recherche + panier
///   - Bannière hero (mise en avant de l'agroécologie / bio)
///   - Catégories (icônes horizontales)
///   - Produits populaires (grille)
///   - Nouveautés (grille)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadHomeData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToCatalogue({int? categoryId, String? search}) {
    // TODO: brancher la navigation réelle vers l'écran Catalogue
    // Navigator.pushNamed(context, '/catalogue', arguments: {...});
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().itemCount;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.eco, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              'FermeEcole',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryDark),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              // TODO: Navigator.pushNamed(context, '/notifications');
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: badges.Badge(
                showBadge: cartCount > 0,
                badgeContent: Text(
                  '$cartCount',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              onPressed: () {
                // TODO: Navigator.pushNamed(context, '/panier');
              },
            ),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.status == LoadStatus.loading || provider.status == LoadStatus.initial) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (provider.status == LoadStatus.error) {
            return _ErrorState(
              message: provider.errorMessage ?? 'Une erreur est survenue.',
              onRetry: provider.loadHomeData,
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: provider.refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  _buildHeroBanner(),
                  const SizedBox(height: 20),
                  _buildCategories(provider),
                  const SizedBox(height: 24),
                  _buildProductSection(
                    title: 'Produits populaires',
                    products: provider.popularProducts,
                  ),
                  const SizedBox(height: 24),
                  _buildProductSection(
                    title: 'Nouveautés',
                    products: provider.newProducts,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: TextField(
        controller: _searchController,
        onSubmitted: (value) => _goToCatalogue(search: value),
        decoration: InputDecoration(
          hintText: 'Rechercher un produit bio...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    // Équivalent de la bannière hero Ogani ("Organic items delivered to
    // your home"), adaptée au contexte agroécologique burkinabè.
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Des produits bio,\ndirectement du producteur',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primaryDark),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fruits, légumes et produits agroécologiques locaux, livrés près de chez toi.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => _goToCatalogue(),
              child: const Text('Voir le catalogue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(ProductProvider provider) {
    if (provider.categories.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SectionHeader(title: 'Catégories'),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: provider.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = provider.categories[index];
              return CategoryItem(
                category: category,
                selected: provider.selectedCategoryId == category.id,
                onTap: () {
                  provider.selectCategory(category.id);
                  _goToCatalogue(categoryId: category.id);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductSection({required String title, required List products}) {
    if (products.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, actionLabel: 'Voir tout', onActionTap: () => _goToCatalogue()),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () {
                  // TODO: Navigator.pushNamed(context, '/produit', arguments: product.id);
                },
                onAddToCart: () {
                  context.read<CartProvider>().addProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} ajouté au panier')),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 48, color: AppColors.textSecondary),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Réessayer')),
          ],
        ),
      ),
    );
  }
}