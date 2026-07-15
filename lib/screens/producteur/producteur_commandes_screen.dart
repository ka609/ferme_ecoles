import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/commande_provider.dart';
import '../../widgets/commande_card.dart';
import '../../widgets/common/empty_state.dart';

class ProducteurCommandesScreen extends StatefulWidget {
  const ProducteurCommandesScreen({super.key});

  @override
  State<ProducteurCommandesScreen> createState() => _ProducteurCommandesScreenState();
}

class _ProducteurCommandesScreenState extends State<ProducteurCommandesScreen> {
  // null = toutes ; sinon filtre par statut exact
  String? _filtreStatut;

  static const _filtres = [
    (label: "Toutes", statut: null),
    (label: "En attente", statut: "EN_ATTENTE"),
    (label: "En préparation", statut: "PREPARATION"),
    (label: "Livrées", statut: "LIVREE"),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetch());
  }

  Future<void> _fetch() async {
    await context.read<CommandeProvider>().fetchCommandes(statut: _filtreStatut);
  }

  void _selectFiltre(String? statut) {
    setState(() => _filtreStatut = statut);
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Commandes reçues")),
      body: RefreshIndicator(
        onRefresh: _fetch,
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _filtres.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filtre = _filtres[index];
                  final selected = _filtreStatut == filtre.statut;

                  return ChoiceChip(
                    label: Text(filtre.label),
                    selected: selected,
                    onSelected: (_) => _selectFiltre(filtre.statut),
                  );
                },
              ),
            ),
            Expanded(
              child: Consumer<CommandeProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.commandes.isEmpty) {
                    return const EmptyState(
                      icon: Icons.receipt_long_outlined,
                      message: "Aucune commande dans cette catégorie",
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.commandes.length,
                    itemBuilder: (context, index) {
                      final commande = provider.commandes[index];

                      return CommandeCard(
                        commande: commande,
                        onTap: () {
                          context.push("/commande/${commande.id}", extra: commande);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}