import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/livraison_provider.dart';


class LivraisonDisponibleScreen extends StatefulWidget {

  const LivraisonDisponibleScreen({
    super.key,
  });

  @override
  State<LivraisonDisponibleScreen> createState() =>
      _LivraisonDisponibleScreenState();
}


class _LivraisonDisponibleScreenState
    extends State<LivraisonDisponibleScreen> {


  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<LivraisonProvider>()
          .fetchLivraisonsDisponibles();

    });

  }



  Future<void> _prendreLivraison(
    int livraisonId,
  ) async {


    final success =
        await context
            .read<LivraisonProvider>()
            .prendreLivraison(
              livraisonId,
            );


    if (!mounted) return;


    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content: Text(

          success

              ? "Livraison prise en charge"

              : "Impossible de prendre cette livraison",

        ),

      ),

    );

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Livraisons disponibles",
        ),

      ),


      body: RefreshIndicator(

        onRefresh: () async {

          await context
              .read<LivraisonProvider>()
              .fetchLivraisonsDisponibles();

        },


        child: Consumer<LivraisonProvider>(

          builder:
              (context, provider, child) {


            if (provider.isLoading) {

              return const Center(

                child:
                    CircularProgressIndicator(),

              );

            }



            if (provider.livraisonsDisponibles.isEmpty) {

              return const Center(

                child: Text(
                  "Aucune livraison disponible",
                ),

              );

            }



            return ListView.builder(

              padding:
                  const EdgeInsets.all(16),


              itemCount:
                  provider.livraisonsDisponibles.length,


              itemBuilder:
                  (context, index) {


                final livraison =
                    provider.livraisonsDisponibles[index];



                return Card(

                  margin:
                      const EdgeInsets.only(
                        bottom: 12,
                      ),


                  child: Padding(

                    padding:
                        const EdgeInsets.all(16),


                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,


                      children: [


                        Text(

                          "Commande #${livraison.commande.numero}",

                          style:
                              const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 16,
                              ),

                        ),



                        const SizedBox(
                          height: 8,
                        ),



                        Text(

                          "Client : ${livraison.commande.clientNom ?? ""}",

                        ),



                        Text(

                          "Adresse : ${livraison.commande.adresseLivraison}",

                        ),



                        Text(

                          "Montant : ${livraison.commande.montantTotal} FCFA",

                        ),



                        const SizedBox(
                          height: 12,
                        ),



                        SizedBox(

                          width:
                              double.infinity,


                          child:
                              ElevatedButton(

                            onPressed: () {

                              _prendreLivraison(
                                livraison.id,
                              );

                            },


                            child:
                                const Text(
                                  "Prendre en charge",
                                ),

                          ),

                        ),

                      ],

                    ),

                  ),

                );

              },

            );

          },

        ),

      ),

    );

  }

}