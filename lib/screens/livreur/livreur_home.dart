import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';

import '../../providers/auth_provider.dart';
import '../../providers/livraison_provider.dart';
import '../../providers/commission_provider.dart';

import '../../widgets/common/stat_card.dart';

class LivreurHome extends StatefulWidget {
  const LivreurHome({
    super.key,
  });

  @override
  State<LivreurHome> createState() => _LivreurHomeState();
}

class _LivreurHomeState extends State<LivreurHome> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LivraisonProvider>().fetchLivraisonsDisponibles();

      context.read<LivraisonProvider>().fetchLivraisons();

      context.read<CommissionProvider>().fetchCommissions();
    });
  }

  Future<void> _refresh() async {
    await context.read<LivraisonProvider>().fetchLivraisonsDisponibles();

    await context.read<LivraisonProvider>().fetchLivraisons();

    await context.read<CommissionProvider>().fetchCommissions();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(
              Icons.local_shipping_outlined,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Espace Livreur",
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: "Forum",
            icon: const Icon(
              Icons.forum_outlined,
            ),
            onPressed: () => context.push(
              AppRoutes.forum,
            ),
          ),
          IconButton(
            tooltip: "Notifications",
            icon: const Icon(
              Icons.notifications_outlined,
            ),
            onPressed: () => context.push(
              AppRoutes.notifications,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BANNIERE

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade700,
                      Colors.green.shade400,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bonjour ${user?.prenom ?? ''}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Gérez vos livraisons rapidement et efficacement",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              Text(
                "Tableau de bord",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(
                height: 16,
              ),

              LayoutBuilder(
                builder: (
                  context,
                  constraints,
                ) {
                  int columns = 2;

                  if (constraints.maxWidth > 900) {
                    columns = 4;
                  } else if (constraints.maxWidth > 600) {
                    columns = 3;
                  }

                  return GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    children: [
                      // DISPONIBLES

                      Consumer<LivraisonProvider>(
                        builder: (
                          context,
                          provider,
                          child,
                        ) {
                          return StatCard(
                            icon: Icons.inventory_2_outlined,
                            value: "${provider.livraisonsDisponibles.length}",
                            label: "Disponibles",
                            onTap: () => context.push(
                              AppRoutes.livraisonsDisponibles,
                            ),
                          );
                        },
                      ),

                      // MES LIVRAISONS

                      Consumer<LivraisonProvider>(
                        builder: (
                          context,
                          provider,
                          child,
                        ) {
                          return StatCard(
                            icon: Icons.local_shipping_outlined,
                            value: "${provider.livraisons.length}",
                            label: "Mes livraisons",
                            onTap: () => context.push(
                              AppRoutes.mesLivraisons,
                            ),
                          );
                        },
                      ),

                      // TERMINEES

                      Consumer<LivraisonProvider>(
                        builder: (
                          context,
                          provider,
                          child,
                        ) {
                          final terminees = provider.livraisons
                              .where(
                                (l) => l.statut.toUpperCase() == "LIVREE",
                              )
                              .length;

                          return StatCard(
                            icon: Icons.check_circle_outline,
                            value: "$terminees",
                            label: "Terminées",
                          );
                        },
                      ),

                      // COMMISSIONS

                      Consumer<CommissionProvider>(
                        builder: (
                          context,
                          provider,
                          child,
                        ) {
                          return StatCard(
                            icon: Icons.account_balance_wallet_outlined,
                            value:
                                "${provider.totalCommissions.toStringAsFixed(0)} FCFA",
                            label: "Commission",
                            onTap: () => context.push(
                              AppRoutes.commissions,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 25,
              ),

              Text(
                "Actions rapides",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(
                height: 12,
              ),

              _actionCard(
                context,
                icon: Icons.delivery_dining_outlined,
                title: "Voir les livraisons disponibles",
                route: AppRoutes.livraisonsDisponibles,
              ),

              _actionCard(
                context,
                icon: Icons.history_outlined,
                title: "Consulter mes livraisons",
                route: AppRoutes.mesLivraisons,
              ),

              _actionCard(
                context,
                icon: Icons.account_balance_wallet_outlined,
                title: "Voir mes commissions",
                route: AppRoutes.commissions,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: () => context.push(route),
      ),
    );
  }
}
