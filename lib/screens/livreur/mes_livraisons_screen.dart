import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../providers/livraison_provider.dart';


class MesLivraisonsScreen extends StatefulWidget {

  const MesLivraisonsScreen({
    super.key,
  });

  @override
  State<MesLivraisonsScreen> createState() =>
      _MesLivraisonsScreenState();

}


class _MesLivraisonsScreenState
    extends State<MesLivraisonsScreen> {


  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<LivraisonProvider>()
          .fetchLivraisons();

    });

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Mes livraisons",
        ),

      ),


      body: RefreshIndicator(

        onRefresh: () async {

          await context
              .read<LivraisonProvider>()
              .fetchLivraisons();

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



            if (provider.livraisons.isEmpty) {

              return const Center(

                child: Text(
                  "Aucune livraison en cours",
                ),

              );

            }



            return ListView.builder(

              padding:
                  const EdgeInsets.all(16),


              itemCount:
                  provider.livraisons.length,


              itemBuilder:
                  (context, index) {


                final livraison =
                    provider.livraisons[index];



                return Card(

                  margin:
                      const EdgeInsets.only(
                        bottom: 12,
                      ),


                  child: ListTile(

                    title: Text(

                      "Commande #${livraison.commande.numero}",

                      style:
                          const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),

                    ),



                    subtitle: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,


                      children: [


                        const SizedBox(
                          height: 6,
                        ),



                        Text(

                          "Client : ${livraison.commande.clientNom ?? ""}",

                        ),



                        Text(

                          "Adresse : ${livraison.commande.adresseLivraison}",

                        ),



                        Text(

                          "Statut : ${livraison.statut}",

                        ),

                      ],

                    ),



                    trailing: const Icon(

                      Icons.arrow_forward_ios,

                      size: 18,

                    ),



                    onTap: () {


                      context.push(

                        "/livreur/livraison/${livraison.id}",

                      );


                    },

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