import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/commission_provider.dart';
import '../../widgets/common/empty_state.dart';

class CommissionScreen extends StatefulWidget {
  const CommissionScreen({
    super.key,
  });

  @override
  State<CommissionScreen> createState() => _CommissionScreenState();
}

class _CommissionScreenState extends State<CommissionScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CommissionProvider>().fetchCommissions();
    });
  }

  Color _statusColor(
    String statut,
  ) {
    switch (statut.toUpperCase()) {
      case "PAYEE":
        return Colors.green;

      case "EN_ATTENTE":
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
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes commissions",
        ),
      ),
      body: Consumer<CommissionProvider>(
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

          if (provider.commissions.isEmpty) {
            return RefreshIndicator(
              onRefresh: provider.fetchCommissions,
              child: ListView(
                children: const [
                  SizedBox(
                    height: 250,
                  ),
                  EmptyState(
                    icon: Icons.payments_outlined,
                    message: "Aucune commission disponible",
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: provider.fetchCommissions,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TOTAL COMMISSION

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade700,
                          Colors.green.shade400,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total gagné",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${provider.totalCommissions.toStringAsFixed(0)} FCFA",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  Text(
                    "Historique des commissions",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  LayoutBuilder(
                    builder: (
                      context,
                      constraints,
                    ) {
                      final columns = constraints.maxWidth > 800 ? 2 : 1;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.commissions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: columns == 2 ? 2 : 1.8,
                        ),
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          final commission = provider.commissions[index];

                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                18,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.payments_outlined,
                                        color: Colors.green,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _statusColor(
                                            commission.statut,
                                          ).withOpacity(
                                            0.15,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          commission.statut,
                                          style: TextStyle(
                                            color: _statusColor(
                                              commission.statut,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  _infoLine(
                                    Icons.local_shipping_outlined,
                                    "Livraison N° ${commission.livraison}",
                                  ),
                                  _infoLine(
                                    Icons.person_outline,
                                    "Livreur : ${commission.livreurNom ?? '-'}",
                                  ),
                                  _infoLine(
                                    Icons.money_outlined,
                                    "Montant : ${commission.montant.toStringAsFixed(0)} FCFA",
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
