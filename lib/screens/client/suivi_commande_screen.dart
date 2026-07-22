import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/livraison_provider.dart';

class SuiviCommandeScreen extends StatefulWidget {
  const SuiviCommandeScreen({
    super.key,
  });

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

  Future<void> _confirmerReception(
    int livraisonId,
  ) async {
    final success = await context.read<LivraisonProvider>().confirmerReception(
          livraisonId,
        );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          success
              ? "Réception confirmée."
              : "Impossible de confirmer la réception.",
        ),
      ),
    );
  }

  Color _statusColor(
    String statut,
  ) {
    switch (statut.toUpperCase()) {
      case "LIVREE":
        return Colors.green;

      case "EN_COURS":
        return Colors.orange;

      case "EN_ATTENTE":
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }

  Widget _info(
    IconData icon,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.green.shade700,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Suivi des livraisons",
        ),
      ),
      body: Consumer<LivraisonProvider>(
        builder: (
          context,
          provider,
          child,
        ) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.livraisons.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => provider.fetchLivraisons(),
              child: ListView(
                children: const [
                  SizedBox(
                    height: 250,
                  ),
                  Center(
                    child: Text(
                      "Aucune livraison en cours.",
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchLivraisons(),
            child: LayoutBuilder(
              builder: (
                context,
                constraints,
              ) {
                final columns = constraints.maxWidth > 700 ? 2 : 1;

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.livraisons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,

                    // augmenter la hauteur des cartes
                    childAspectRatio: columns == 1 ? 1.15 : 1.25,
                  ),
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final livraison = provider.livraisons[index];

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    livraison.commandeNumero ??
                                        "Commande #${livraison.commande}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _statusColor(
                                      livraison.statut,
                                    ).withOpacity(
                                      0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: Text(
                                    livraison.statut,
                                    style: TextStyle(
                                      color: _statusColor(
                                        livraison.statut,
                                      ),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 24,
                            ),
                            _info(
                              Icons.person_outline,
                              "Client : ${livraison.clientNom ?? '-'}",
                            ),
                            _info(
                              Icons.location_on_outlined,
                              "Adresse : ${livraison.adresseLivraison ?? '-'}",
                            ),
                            _info(
                              Icons.payments_outlined,
                              "Montant : ${livraison.montantTotal ?? 0} FCFA",
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (livraison.statut.toUpperCase() == "LIVREE")
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => _confirmerReception(
                                    livraison.id,
                                  ),
                                  icon: const Icon(
                                    Icons.check_circle_outline,
                                  ),
                                  label: const Text(
                                    "Confirmer la réception",
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
