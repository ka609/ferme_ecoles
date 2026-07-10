import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/livraison_provider.dart';

class LivraisonDetailScreen extends StatefulWidget {
  final int livraisonId;

  const LivraisonDetailScreen({
    super.key,
    required this.livraisonId,
  });

  @override
  State<LivraisonDetailScreen> createState() =>
      _LivraisonDetailScreenState();
}

class _LivraisonDetailScreenState
    extends State<LivraisonDetailScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<LivraisonProvider>()
          .fetchLivraisonDetail(
            widget.livraisonId,
          );
    });
  }

  Future<void> _marquerLivree() async {
    final success =
        await context
            .read<LivraisonProvider>()
            .marquerLivraisonEffectuee(
              widget.livraisonId,
            );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? "Livraison terminée"
              : "Erreur lors de la livraison",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détail livraison"),
      ),

      body: Consumer<LivraisonProvider>(
        builder: (context, provider, child) {

          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final livraison =
              provider.livraisonDetail;

          if (livraison == null) {
            return const Center(
              child: Text(
                "Livraison introuvable",
              ),
            );
          }

          final commande =
              livraison["commande"] ?? {};

          final lignes =
              commande["lignes"] ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  "Commande #${commande["numero"] ?? ""}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Client : ${commande["client_nom"] ?? ""}",
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Adresse : ${commande["adresse_livraison"] ?? ""}",
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Statut : ${livraison["statut"] ?? ""}",
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Montant : ${commande["montant_total"] ?? 0} FCFA",
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Produits",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ...lignes.map((ligne) {

                  return Card(
                    child: ListTile(
                      title: Text(
                        ligne["produit_nom"] ?? "",
                      ),

                      subtitle: Text(
                        "Quantité : ${ligne["quantite"] ?? 0}",
                      ),

                      trailing: Text(
                        "${ligne["sous_total"] ?? 0} FCFA",
                      ),
                    ),
                  );

                }),

                const SizedBox(height: 24),

                if (
                  livraison["statut"]
                      .toString()
                      .toUpperCase() == "EN_COURS"
                )
                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: _marquerLivree,

                      child: const Text(
                        "Marquer comme livrée",
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}