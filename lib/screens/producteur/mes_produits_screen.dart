import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/produit_provider.dart';
import '../../widgets/produit_card.dart';


class MesProduitsScreen extends StatefulWidget {
  const MesProduitsScreen({super.key});

  @override
  State<MesProduitsScreen> createState() =>
      _MesProduitsScreenState();
}


class _MesProduitsScreenState
    extends State<MesProduitsScreen> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<ProduitProvider>()
          .fetchMesProduits();

    });
  }



  Future<void> _supprimerProduit(
    int id,
  ) async {

    final success =
        await context
            .read<ProduitProvider>()
            .deleteProduit(id);


    if (!mounted) return;


    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          success
              ? "Produit supprimé"
              : "Erreur lors de la suppression",
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Mes produits",
        ),
      ),



      floatingActionButton:
          FloatingActionButton(

        onPressed: () {

          Navigator.pushNamed(
            context,
            "/producteur/produit/ajouter",
          );

        },

        child: const Icon(
          Icons.add,
        ),
      ),



      body:

          RefreshIndicator(

        onRefresh: () async {

          await context
              .read<ProduitProvider>()
              .fetchMesProduits();

        },


        child:

            Consumer<ProduitProvider>(

          builder:
              (context, provider, child) {


            if (provider.isLoading) {

              return const Center(
                child:
                    CircularProgressIndicator(),
              );

            }



            if (provider.mesProduits.isEmpty) {

              return const Center(
                child:
                    Text(
                  "Aucun produit disponible",
                ),
              );

            }



            return ListView.builder(

              padding:
                  const EdgeInsets.all(16),


              itemCount:
                  provider.mesProduits.length,


              itemBuilder:
                  (context, index) {


                final produit =
                    provider.mesProduits[index];



                return ProduitCard(

                  produit: produit,


                  onTap: () {

                    Navigator.pushNamed(
                      context,
                      "/producteur/produit/${produit.id}",
                      arguments: produit,
                    );

                  },



                  actions: [

                    IconButton(

                      icon:
                          const Icon(
                        Icons.edit,
                      ),


                      onPressed: () {

                        Navigator.pushNamed(
                          context,
                          "/producteur/produit/modifier",
                          arguments: produit,
                        );

                      },

                    ),



                    IconButton(

                      icon:
                          const Icon(
                        Icons.delete,
                      ),


                      onPressed: () {

                        _supprimerProduit(
                          produit.id,
                        );

                      },

                    ),

                  ],

                );

              },

            );

          },

        ),

      ),

    );

  }

}