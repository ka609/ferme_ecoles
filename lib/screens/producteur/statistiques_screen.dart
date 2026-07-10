import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/statistique_provider.dart';


class StatistiquesScreen extends StatefulWidget {
  const StatistiquesScreen({
    super.key,
  });

  @override
  State<StatistiquesScreen> createState() =>
      _StatistiquesScreenState();
}


class _StatistiquesScreenState
    extends State<StatistiquesScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<StatistiqueProvider>()
          .fetchStatistiqueProducteur();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Statistiques",
        ),
      ),

      body: Consumer<StatistiqueProvider>(
        builder: (context, provider, child) {

          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          final data = provider.statistique;


          if (data == null) {
            return const Center(
              child: Text(
                "Aucune statistique disponible",
              ),
            );
          }


          return Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [

                _StatCard(
                  title: "Produits",
                  value:
                      "${data.nombreProduits}",
                  icon:
                      Icons.inventory,
                ),


                _StatCard(
                  title: "Produits validés",
                  value:
                      "${data.produitsValides}",
                  icon:
                      Icons.verified,
                ),


                _StatCard(
                  title: "Produits disponibles",
                  value:
                      "${data.produitsDisponibles}",
                  icon:
                      Icons.check_circle,
                ),


                _StatCard(
                  title: "Stock total",
                  value:
                      "${data.stockTotal}",
                  icon:
                      Icons.storage,
                ),


                _StatCard(
                  title: "Commandes",
                  value:
                      "${data.nombreCommandes}",
                  icon:
                      Icons.shopping_cart,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


class _StatCard extends StatelessWidget {

  final String title;

  final String value;

  final IconData icon;


  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });


  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      child: ListTile(

        leading: Icon(
          icon,
        ),


        title: Text(
          title,
        ),


        trailing: Text(
          value,

          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}