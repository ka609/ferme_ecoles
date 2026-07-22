import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';
import '../../providers/panier_provider.dart';
import '../../widgets/common/empty_state.dart';

class PanierScreen extends StatefulWidget {
  const PanierScreen({
    super.key,
  });

  @override
  State<PanierScreen> createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PanierProvider>().fetchPaniers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes paniers"),
      ),
      body: Consumer<PanierProvider>(
        builder: (context, panierProvider, child) {
          if (panierProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (panierProvider.paniers.isEmpty) {
            return const EmptyState(
              icon: Icons.shopping_cart_outlined,
              message: "Votre panier est vide",
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await panierProvider.fetchPaniers();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: panierProvider.paniers.length,
              itemBuilder: (context, index) {
                final panier = panierProvider.paniers[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.shopping_cart),
                    ),
                    title: Text(
                      panier.producteurNom ?? "Producteur",
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${panier.articles.length} article(s)",
                        ),
                        if (panier.dateCreation != null)
                          Text(
                            "Créé le : ${panier.dateCreation!.day}/${panier.dateCreation!.month}/${panier.dateCreation!.year}",
                          ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                    onTap: () {
                      context.push(
                        AppRoutes.panierArticles.replaceFirst(
                          ":id",
                          panier.id.toString(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}