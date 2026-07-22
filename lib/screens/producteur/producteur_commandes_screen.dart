import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/commande_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../models/commande_model.dart';

class ProducteurCommandesScreen extends StatefulWidget {
  const ProducteurCommandesScreen({
    super.key,
  });

  @override
  State<ProducteurCommandesScreen> createState() =>
      _ProducteurCommandesScreenState();
}

class _ProducteurCommandesScreenState extends State<ProducteurCommandesScreen> {
  String? _filtreStatut;

  final List<Map<String, dynamic>> _filtres = [
    {
      "label": "Toutes",
      "statut": null,
    },
    {
      "label": "En attente",
      "statut": "EN_ATTENTE",
    },
    {
      "label": "Préparation",
      "statut": "PREPARATION",
    },
    {
      "label": "Livraison",
      "statut": "EN_LIVRAISON",
    },
    {
      "label": "Livrées",
      "statut": "LIVREE",
    },
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetch();
    });
  }

  Future<void> _fetch() async {
    await context.read<CommandeProvider>().fetchCommandes(
          statut: _filtreStatut,
        );
  }

  Future<void> _changerStatut(
    Commande commande,
    String statut,
  ) async {
    final success = await context.read<CommandeProvider>().updateCommandeStatut(
          commandeId: commande.id,
          statut: statut,
        );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "Statut mis à jour" : "Erreur lors de la mise à jour",
        ),
      ),
    );
  }

  Color _statusColor(
    String statut,
  ) {
    switch (statut.toUpperCase()) {
      case "EN_ATTENTE":
        return Colors.orange;

      case "PREPARATION":
        return Colors.blue;

      case "EN_LIVRAISON":
        return Colors.purple;

      case "LIVREE":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  Widget _actionButton(
    Commande commande,
  ) {
    switch (commande.statut.toUpperCase()) {
      case "EN_ATTENTE":
        return ElevatedButton.icon(
          onPressed: () => _changerStatut(
            commande,
            "PREPARATION",
          ),
          icon: const Icon(
            Icons.inventory_2_outlined,
          ),
          label: const Text(
            "Préparer",
          ),
        );

      case "PREPARATION":
        return ElevatedButton.icon(
          onPressed: () => _changerStatut(
            commande,
            "EN_LIVRAISON",
          ),
          icon: const Icon(
            Icons.local_shipping_outlined,
          ),
          label: const Text(
            "Envoyer",
          ),
        );

      case "EN_LIVRAISON":
        return ElevatedButton.icon(
          onPressed: () => _changerStatut(
            commande,
            "LIVREE",
          ),
          icon: const Icon(
            Icons.check_circle_outline,
          ),
          label: const Text(
            "Livrée",
          ),
        );

      default:
        return const SizedBox();
    }
  }

  Widget _commandeCard(
    Commande commande,
  ) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
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
                    "Commande ${commande.numero ?? '#${commande.id}'}",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(
                      commande.statut,
                    ).withOpacity(
                      0.15,
                    ),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    commande.statut,
                    style: TextStyle(
                      color: _statusColor(
                        commande.statut,
                      ),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Client : ${commande.clientNom ?? '-'}",
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "Adresse : ${commande.adresseLivraison ?? '-'}",
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "Montant : ${commande.montantTotal ?? 0} FCFA",
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    commande,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    context.push(
                      "/commande/${commande.id}",
                      extra: commande,
                    );
                  },
                  icon: const Icon(
                    Icons.visibility_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Commandes reçues",
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: _filtres.length,
              itemBuilder: (
                context,
                index,
              ) {
                final filtre = _filtres[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                  ),
                  child: ChoiceChip(
                    label: Text(
                      filtre["label"],
                    ),
                    selected: _filtreStatut == filtre["statut"],
                    onSelected: (_) {
                      setState(() {
                        _filtreStatut = filtre["statut"];
                      });

                      _fetch();
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetch,
              child: Consumer<CommandeProvider>(
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

                  if (provider.commandes.isEmpty) {
                    return const EmptyState(
                      icon: Icons.receipt_long_outlined,
                      message: "Aucune commande reçue",
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.commandes.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return _commandeCard(
                        provider.commandes[index],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
