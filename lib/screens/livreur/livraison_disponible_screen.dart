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

    WidgetsBinding.instance.addPostFrameCallback((_) {

      context
          .read<LivraisonProvider>()
          .fetchLivraisonsDisponibles();

    });
  }



  Future<void> _prendreLivraison(
    int livraisonId,
  ) async {

    final livraison =
        await context
            .read<LivraisonProvider>()
            .prendreLivraison(
              livraisonId,
            );


    if (!mounted) return;


    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        behavior:
            SnackBarBehavior.floating,

        content: Text(

          livraison != null

              ? "Livraison prise en charge."

              : "Impossible de prendre cette livraison.",

        ),

      ),

    );
  }



  Widget _infoRow(
    IconData icon,
    String label,
    String value,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
            bottom: 10,
          ),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.start,


        children: [

          Icon(
            icon,
            size: 20,
            color:
                Colors.green.shade700,
          ),


          const SizedBox(
            width: 10,
          ),


          Expanded(

            child: RichText(

              text:
                  TextSpan(

                style:
                    const TextStyle(
                      color:
                          Colors.black87,
                      fontSize: 14,
                    ),

                children: [

                  TextSpan(

                    text:
                        "$label : ",

                    style:
                        const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),

                  ),

                  TextSpan(
                    text:
                        value,
                  ),

                ],

              ),

            ),

          ),

        ],

      ),

    );
  }





  Widget _statusBadge(
    String statut,
  ) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),


      decoration:
          BoxDecoration(

        color:
            Colors.orange.shade100,

        borderRadius:
            BorderRadius.circular(20),

      ),


      child:
          Text(

        statut,

        style:
            TextStyle(

          color:
              Colors.orange.shade800,

          fontWeight:
              FontWeight.bold,

          fontSize:
              12,

        ),

      ),

    );

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar:
          AppBar(

        title:
            const Text(
          "Livraisons disponibles",
        ),

      ),



      body:
          Consumer<LivraisonProvider>(

        builder:
            (
              context,
              provider,
              child,
            ) {


          if (provider.isLoading) {

            return const Center(

              child:
                  CircularProgressIndicator(),

            );

          }



          if (provider.livraisonsDisponibles.isEmpty) {

            return RefreshIndicator(

              onRefresh:
                  () =>
                      provider
                          .fetchLivraisonsDisponibles(),


              child:
                  ListView(

                children: const [

                  SizedBox(
                    height: 250,
                  ),

                  Center(

                    child:
                        Text(
                      "Aucune livraison disponible.",
                    ),

                  ),

                ],

              ),

            );

          }




          return RefreshIndicator(

            onRefresh:
                () =>
                    provider
                        .fetchLivraisonsDisponibles(),



            child:
                ListView.builder(

              padding:
                  const EdgeInsets.all(16),


              itemCount:
                  provider
                      .livraisonsDisponibles
                      .length,



              itemBuilder:
                  (
                    context,
                    index,
                  ) {


                final livraison =
                    provider
                        .livraisonsDisponibles[index];



                return Card(

                  elevation:
                      3,


                  margin:
                      const EdgeInsets.only(
                        bottom: 16,
                      ),


                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(18),

                  ),



                  child:
                      Padding(

                    padding:
                        const EdgeInsets.all(18),



                    child:
                        Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,


                      children: [



                        Row(

                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,


                          children: [


                            Expanded(

                              child:
                                  Text(

                                livraison.commandeNumero ??
                                    "Commande #${livraison.commande}",


                                style:
                                    const TextStyle(

                                  fontSize:
                                      18,

                                  fontWeight:
                                      FontWeight.bold,

                                ),

                              ),

                            ),



                            _statusBadge(
                              livraison.statut,
                            ),

                          ],

                        ),



                        const Divider(
                          height: 24,
                        ),



                        _infoRow(

                          Icons.person_outline,

                          "Client",

                          livraison.clientNom ??
                              "-",

                        ),



                        _infoRow(

                          Icons.phone_outlined,

                          "Téléphone",

                          livraison.clientTelephone ??
                              "-",

                        ),



                        _infoRow(

                          Icons.location_on_outlined,

                          "Adresse",

                          livraison.adresseLivraison ??
                              "-",

                        ),



                        _infoRow(

                          Icons.payments_outlined,

                          "Montant",

                          "${livraison.montantTotal ?? 0} FCFA",

                        ),



                        const SizedBox(
                          height: 12,
                        ),



                        SizedBox(

                          width:
                              double.infinity,


                          child:
                              ElevatedButton.icon(

                            onPressed:
                                () =>
                                    _prendreLivraison(
                                      livraison.id,
                                    ),


                            icon:
                                const Icon(
                              Icons.local_shipping_outlined,
                            ),


                            label:
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

            ),

          );

        },

      ),

    );

  }
}