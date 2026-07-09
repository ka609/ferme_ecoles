import 'package:flutter/material.dart';

import '../models/commande_model.dart';


class CommandeCard extends StatelessWidget {

  final Commande commande;
  final VoidCallback? onTap;

  const CommandeCard({
    super.key,
    required this.commande,
    this.onTap,
  });


  Color _statusColor(String statut) {

    switch (statut.toUpperCase()) {

      case "LIVREE":
        return Colors.green;

      case "EN_LIVRAISON":
        return Colors.orange;

      case "VALIDEE":
        return Colors.blue;

      case "ANNULEE":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }


  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.only(
        bottom: 12,
      ),


      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),


      child: InkWell(

        borderRadius:
            BorderRadius.circular(12),


        onTap: onTap,


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

                  Text(

                    commande.numero,

                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),


                  Container(

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),


                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(20),


                      color:
                          _statusColor(
                            commande.statut,
                          ).withOpacity(0.15),
                    ),


                    child: Text(

                      commande.statut,

                      style: TextStyle(

                        color:
                            _statusColor(
                              commande.statut,
                            ),

                        fontWeight:
                            FontWeight.w600,

                        fontSize:
                            12,
                      ),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 12),


              if (commande.producteurNom != null)

                Text(
                  "Producteur : ${commande.producteurNom}",
                ),


              const SizedBox(height: 6),


              Text(
                "Adresse : ${commande.adresseLivraison}",
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
              ),


              const SizedBox(height: 6),


              Text(
                "${commande.montantTotal} FCFA",

                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),


              if (commande.dateCommande != null)

                Padding(

                  padding:
                      const EdgeInsets.only(
                    top: 6,
                  ),

                  child: Text(
                    "${commande.dateCommande!.day}/"
                    "${commande.dateCommande!.month}/"
                    "${commande.dateCommande!.year}",

                    style:
                        const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}