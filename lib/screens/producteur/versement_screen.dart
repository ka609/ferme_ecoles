import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/versement_provider.dart';
import '../../models/versement_model.dart';

class VersementScreen extends StatefulWidget {
  const VersementScreen({
    super.key,
  });

  @override
  State<VersementScreen> createState() => _VersementScreenState();
}

class _VersementScreenState extends State<VersementScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VersementProvider>().fetchVersements();
    });
  }

  Future<void> _refresh() async {
    await context.read<VersementProvider>().fetchVersements();
  }

  Color _statutColor(String statut) {
    switch (statut) {
      case "PAYE":
        return Colors.green;

      case "EN_ATTENTE":
        return Colors.orange;

      case "ANNULE":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes versements",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<VersementProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (provider.versements.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(
                      height: 250,
                    ),
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        "Aucun versement disponible",
                      ),
                    ),
                  ],
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.versements.length,
                    itemBuilder: (context, index) {
                      final versement = provider.versements[index];

                      return _VersementCard(
                        versement: versement,
                        statutColor: _statutColor(
                          versement.statut,
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _VersementCard extends StatelessWidget {
  final Versement versement;

  final Color statutColor;

  const _VersementCard({
    required this.versement,
    required this.statutColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(
        bottom: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    versement.commandeNumero ?? "Commande",
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                _StatutBadge(
                  statut: versement.statut,
                  color: statutColor,
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            _InfoRow(
              icon: Icons.shopping_cart_outlined,
              label: "Montant commande",
              value: "${versement.montant.toStringAsFixed(0)} FCFA",
            ),
            _InfoRow(
              icon: Icons.percent_outlined,
              label: "Commission",
              value:
                  "${versement.commissionPlateforme.toStringAsFixed(0)} FCFA",
            ),
            const Divider(
              height: 24,
            ),
            _InfoRow(
              icon: Icons.payments_outlined,
              label: "Montant reçu",
              value: "${versement.montantNet.toStringAsFixed(0)} FCFA",
              bold: true,
            ),
            if (versement.dateVersement != null)
              _InfoRow(
                icon: Icons.calendar_month_outlined,
                label: "Date versement",
                value: "${versement.dateVersement!.day}/"
                    "${versement.dateVersement!.month}/"
                    "${versement.dateVersement!.year}",
              ),
          ],
        ),
      ),
    );
  }
}

class _StatutBadge extends StatelessWidget {
  final String statut;

  final Color color;

  const _StatutBadge({
    required this.statut,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statut,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;

  final String label;

  final String value;

  final bool bold;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              label,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
