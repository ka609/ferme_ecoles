import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/routes/app_routes.dart';

import '../../providers/commande_provider.dart';
import '../../widgets/commande_card.dart';
import '../../widgets/common/empty_state.dart';

class CommandeScreen extends StatefulWidget {
  const CommandeScreen({super.key});

  @override
  State<CommandeScreen> createState() => _CommandeScreenState();
}

class _CommandeScreenState extends State<CommandeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CommandeProvider>().fetchCommandes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes commandes"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<CommandeProvider>().fetchCommandes();
        },
        child: Consumer<CommandeProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.commandes.isEmpty) {
              return const EmptyState(
                icon: Icons.receipt_long_outlined,
                message: "Vous n'avez pas encore passé de commande",
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
                    context.push(AppRoutes.commandeDetail, extra: commande);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}