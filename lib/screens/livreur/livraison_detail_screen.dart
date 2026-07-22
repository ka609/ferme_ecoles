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
  State<LivraisonDetailScreen> createState() => _LivraisonDetailScreenState();
}

class _LivraisonDetailScreenState extends State<LivraisonDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LivraisonProvider>().fetchLivraisonDetail(
            widget.livraisonId,
          );
    });
  }

  Future<void> _marquerLivree() async {
    final success =
        await context.read<LivraisonProvider>().marquerLivraisonEffectuee(
              widget.livraisonId,
            );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? "Livraison terminée avec succès"
              : "Erreur lors de la livraison",
        ),
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 22,
            color: Colors.green,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
          "Détail livraison",
        ),
      ),
      body: Consumer<LivraisonProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final livraison = provider.livraisonDetail;

          if (livraison == null) {
            return const Center(
              child: Text(
                "Livraison introuvable",
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // En-tête commande
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          livraison.commandeNumero ??
                              "Commande #${livraison.commande}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _infoTile(
                          Icons.person_outline,
                          "Client",
                          livraison.clientNom ?? "-",
                        ),
                        _infoTile(
                          Icons.phone_outlined,
                          "Téléphone",
                          livraison.clientTelephone ?? "-",
                        ),
                        _infoTile(
                          Icons.location_on_outlined,
                          "Adresse",
                          livraison.adresseLivraison ?? "-",
                        ),
                        _infoTile(
                          Icons.payments_outlined,
                          "Montant",
                          "${livraison.montantTotal ?? 0} FCFA",
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // Statut livraison

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_shipping_outlined,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Statut",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              livraison.statut,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                if (livraison.statut.toUpperCase() == "EN_COURS")
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.check_circle_outline,
                      ),
                      onPressed: _marquerLivree,
                      label: const Text(
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
