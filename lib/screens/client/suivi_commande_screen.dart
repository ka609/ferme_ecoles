import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/livraison_provider.dart';
import '../../widgets/commande_card.dart';

class SuiviCommandeScreen extends StatefulWidget {
  const SuiviCommandeScreen({super.key});

  @override
  State<SuiviCommandeScreen> createState() => _SuiviCommandeScreenState();
}

class _SuiviCommandeScreenState extends State<SuiviCommandeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LivraisonProvider>().fetchLivraisons();
    });
  }

  Future<void> _confirmerReception(int livraisonId) async {
    final success = await context
        .read<LivraisonProvider>()
        .confirmerReception(livraisonId);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? "Réception confirmée"
              : "Impossible de confirmer la réception",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suivi des livraisons"),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          await context
              .read<LivraisonProvider>()
              .fetchLivraisons();
        },

        child: Consumer<LivraisonProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (provider.livraisons.isEmpty) {
              return const Center(
                child: Text("Aucune livraison en cours"),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.livraisons.length,

              itemBuilder: (context, index) {
                final livraison = provider.livraisons[index];

                return Column(
                  children: [
                    CommandeCard(
                      commande: livraison.commande,
                    ),

                    if (livraison.statut.toUpperCase() == "LIVREE")
                      SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(
                          onPressed: () {
                            _confirmerReception(
                              livraison.id,
                            );
                          },

                          child: const Text(
                            "Confirmer la réception",
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}