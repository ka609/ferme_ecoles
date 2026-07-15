import 'package:flutter/material.dart';

import '../../models/commande_model.dart';


class CommandeDetailScreen extends StatelessWidget {

  final Commande commande;


  const CommandeDetailScreen({
    super.key,
    required this.commande,
  });



  Color _statutColor(String statut) {

    switch(statut){

      case "EN_ATTENTE":
        return Colors.orange;

      case "VALIDEE":
        return Colors.blue;

      case "EN_LIVRAISON":
        return Colors.purple;

      case "LIVREE":
        return Colors.green;

      case "ANNULEE":
        return Colors.red;

      default:
        return Colors.grey;

    }

  }




  String _formatDate(DateTime? date){

    if(date == null){
      return "Date inconnue";
    }

    return "${date.day}/${date.month}/${date.year} "
        "${date.hour}:${date.minute}";

  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(
          "Commande ${commande.numero}",
        ),

      ),



      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [



            Card(

              child: Padding(

                padding:
                    const EdgeInsets.all(16),


                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,


                  children: [


                    Row(

                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,


                      children: [


                        const Text(
                          "Statut",
                          style:
                              TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                        ),



                        Container(

                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),


                          decoration:
                              BoxDecoration(

                                color:
                                    _statutColor(
                                      commande.statut,
                                    )
                                    .withOpacity(0.15),


                                borderRadius:
                                    BorderRadius.circular(20),

                              ),


                          child: Text(

                            commande.statut,

                            style:
                                TextStyle(

                                  color:
                                      _statutColor(
                                        commande.statut,
                                      ),

                                  fontWeight:
                                      FontWeight.bold,

                                ),

                          ),

                        ),


                      ],

                    ),



                    const SizedBox(height: 16),



                    Text(
                      "Numéro : ${commande.numero}",
                    ),


                    const SizedBox(height: 8),


                    Text(
                      "Date : ${_formatDate(
                        commande.dateCommande,
                      )}",
                    ),


                    const SizedBox(height: 8),


                    Text(
                      "Producteur : "
                      "${commande.producteurNom ?? 'Non défini'}",
                    ),


                  ],

                ),

              ),

            ),





            const SizedBox(height: 16),





            Card(

              child: Padding(

                padding:
                    const EdgeInsets.all(16),


                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,


                  children: [


                    const Text(

                      "Adresse de livraison",

                      style:
                          TextStyle(

                            fontWeight:
                                FontWeight.bold,

                          ),

                    ),


                    const SizedBox(height: 8),


                    Text(
                      commande.adresseLivraison,
                    ),


                  ],

                ),

              ),

            ),





            const SizedBox(height: 16),





            const Text(

              "Produits commandés",

              style:
                  TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,

                  ),

            ),




            const SizedBox(height: 10),





            ...commande.lignes.map(

              (ligne) {


                return Card(

                  child: ListTile(

                    title: Text(
                      ligne.produitNom ??
                      "Produit",
                    ),


                    subtitle: Text(

                      "Quantité : "
                      "${ligne.quantite}",

                    ),


                    trailing: Text(

                      "${ligne.sousTotal} FCFA",

                      style:
                          const TextStyle(

                            fontWeight:
                                FontWeight.bold,

                          ),

                    ),

                  ),

                );

              },

            ),






            const SizedBox(height: 20),





            Card(

              child: Padding(

                padding:
                    const EdgeInsets.all(16),


                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,


                  children: [


                    const Text(

                      "Total",

                      style:
                          TextStyle(

                            fontSize: 18,

                            fontWeight:
                                FontWeight.bold,

                          ),

                    ),



                    Text(

                      "${commande.montantTotal} FCFA",

                      style:
                          const TextStyle(

                            fontSize: 18,

                            fontWeight:
                                FontWeight.bold,

                          ),

                    ),


                  ],

                ),

              ),

            ),


          ],

        ),

      ),

    );

  }

}