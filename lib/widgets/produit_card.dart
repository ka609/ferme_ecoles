import 'package:flutter/material.dart';

import '../models/produit_model.dart';


class ProduitCard extends StatelessWidget {

  final Produit produit;

  final VoidCallback? onTap;

  final List<Widget>? actions;


  const ProduitCard({
    super.key,
    required this.produit,
    this.onTap,
    this.actions,
  });


  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),


      child: InkWell(

        borderRadius: BorderRadius.circular(12),

        onTap: onTap,


        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [

            // Image produit
            Expanded(

              child: ClipRRect(

                borderRadius:
                    const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),


                child: produit.image != null

                    ? Image.network(
                        produit.image!,

                        width:
                            double.infinity,

                        fit:
                            BoxFit.cover,
                      )

                    : Container(

                        width:
                            double.infinity,

                        color:
                            Colors.grey.shade200,


                        child:
                            const Icon(
                          Icons.image,
                          size: 50,
                        ),
                      ),
              ),
            ),



            // Informations produit
            Padding(

              padding:
                  const EdgeInsets.all(10),


              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children: [

                  Text(

                    produit.nom,

                    maxLines:
                        1,

                    overflow:
                        TextOverflow.ellipsis,


                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),



                  const SizedBox(
                    height: 6,
                  ),



                  Text(

                    "${produit.prix} FCFA",

                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),



                  const SizedBox(
                    height: 6,
                  ),



                  if (produit.producteurNom != null)

                    Text(

                      produit.producteurNom ?? "",

                      maxLines:
                          1,

                      overflow:
                          TextOverflow.ellipsis,


                      style:
                          const TextStyle(
                        fontSize:
                            12,
                      ),
                    ),



                  // Actions producteur
                  if (actions != null &&
                      actions!.isNotEmpty)

                    Row(

                      mainAxisAlignment:
                          MainAxisAlignment.end,


                      children:
                          actions!,
                    ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}