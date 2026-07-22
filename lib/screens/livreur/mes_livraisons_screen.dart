import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../providers/livraison_provider.dart';

class MesLivraisonsScreen extends StatefulWidget {
  const MesLivraisonsScreen({
    super.key,
  });

  @override
  State<MesLivraisonsScreen> createState() => _MesLivraisonsScreenState();
}

class _MesLivraisonsScreenState extends State<MesLivraisonsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LivraisonProvider>().fetchLivraisons();
    });
  }

  Color _statusColor(
    String statut,
  ) {
    switch (statut.toUpperCase()) {
      case "LIVREE":
        return Colors.green;

      case "EN_COURS":
        return Colors.orange;

      case "ANNULEE":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  Widget _infoLine(
    IconData icon,
    String text,
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
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
          "Mes livraisons",
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
                      "Aucune livraison disponible.",
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
                final isLarge = constraints.maxWidth > 700;

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.livraisons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isLarge ? 2 : 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isLarge ? 1.8 : 1.25,
                  ),
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final livraison = provider.livraisons[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        context.push(
                          AppRoutes.livraisonDetail.replaceFirst(
                            ':id',
                            livraison.id.toString(),
                          ),
                        );
                      },
                      child: Card(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      livraison.commandeNumero ??
                                          "Commande #${livraison.commande}",
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
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
                              _infoLine(
                                Icons.person_outline,
                                "Client : ${livraison.clientNom ?? '-'}",
                              ),
                              _infoLine(
                                Icons.phone_outlined,
                                livraison.clientTelephone != null
                                    ? "Téléphone : ${livraison.clientTelephone}"
                                    : "Téléphone : -",
                              ),
                              _infoLine(
                                Icons.location_on_outlined,
                                "Adresse : ${livraison.adresseLivraison ?? '-'}",
                              ),
                              _infoLine(
                                Icons.payments_outlined,
                                "Montant : ${livraison.montantTotal ?? 0} FCFA",
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      "Voir détail",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
