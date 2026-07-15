import 'package:flutter/material.dart';

import '../../models/produit_model.dart';
import 'common/app_card.dart';


class ProduitCard extends StatelessWidget {

  final Produit produit;

  final VoidCallback? onTap;

  final VoidCallback? onAddCart;

  final VoidCallback? onReview;

  final List<Widget>? actions;


  const ProduitCard({

    super.key,

    required this.produit,

    this.onTap,

    this.onAddCart,

    this.onReview,

    this.actions,

  });





  @override
  Widget build(BuildContext context) {


    return AppCard(

      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      padding: EdgeInsets.zero,


      child: InkWell(

        borderRadius: BorderRadius.circular(16),

        onTap: onTap,


        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [



            Stack(

              children: [


                ClipRRect(

                  borderRadius:
                      const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),


                  child: SizedBox(

                    height: 170,

                    width: double.infinity,


                    child: produit.image != null

                        ? Image.network(

                            produit.image!,

                            fit: BoxFit.cover,

                          )

                        : Container(

                            color: Colors.green
                                .withValues(alpha: 0.15),


                            child: const Icon(

                              Icons.eco,

                              size: 50,

                            ),

                          ),

                  ),

                ),





                Positioned(

                  top: 10,

                  right: 10,


                  child: Container(

                    padding:
                        const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),


                    decoration: BoxDecoration(

                      color: produit.disponible
                          ? Colors.green
                          : Colors.red,


                      borderRadius:
                          BorderRadius.circular(20),

                    ),


                    child: Text(

                      produit.disponible
                          ? "Disponible"
                          : "Rupture",


                      style:
                          const TextStyle(

                            color: Colors.white,

                            fontSize: 12,

                            fontWeight:
                                FontWeight.bold,

                          ),

                    ),

                  ),

                ),


              ],

            ),





            Padding(

              padding:
                  const EdgeInsets.all(14),


              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children: [



                  Text(

                    produit.nom,

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,


                    style:
                        const TextStyle(

                          fontSize: 17,

                          fontWeight:
                              FontWeight.bold,

                        ),

                  ),





                  const SizedBox(height: 6),





                  Row(

                    children: [


                      const Icon(

                        Icons.person_outline,

                        size: 16,

                      ),


                      const SizedBox(width: 5),


                      Expanded(

                        child: Text(

                          produit.producteurNom ??
                              "Producteur",

                          maxLines: 1,

                          overflow:
                              TextOverflow.ellipsis,

                          style:
                              Theme.of(context)
                                  .textTheme
                                  .bodySmall,

                        ),

                      ),

                    ],

                  ),





                  const SizedBox(height: 10),





                  Row(

                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,


                    children: [


                      Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,


                        children: [


                          const Text(
                            "Prix",
                            style:
                                TextStyle(
                                  fontSize: 12,
                                ),
                          ),


                          Text(

                            "${produit.prix.toStringAsFixed(0)} FCFA",

                            style:
                                const TextStyle(

                                  fontSize: 16,

                                  fontWeight:
                                      FontWeight.bold,

                                ),

                          ),


                        ],

                      ),





                      Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.end,


                        children: [


                          const Text(
                            "Stock",
                            style:
                                TextStyle(
                                  fontSize: 12,
                                ),
                          ),


                          Text(

                            "${produit.stock.toStringAsFixed(0)} ${produit.unite}",

                            style:
                                const TextStyle(

                                  fontWeight:
                                      FontWeight.w600,

                                ),

                          ),


                        ],

                      ),



                    ],

                  ),





                  const SizedBox(height: 10),





                  Row(

                    children: [


                      const Icon(

                        Icons.star,

                        size: 18,

                        color: Colors.amber,

                      ),


                      const SizedBox(width: 4),


                      Text(

                        "${produit.noteMoyenne.toStringAsFixed(1)}",

                      ),


                      Text(

                        " (${produit.nombreAvis})",

                        style:
                            Theme.of(context)
                                .textTheme
                                .bodySmall,

                      ),


                      const Spacer(),



                      if(actions != null)

                        ...actions!



                      else

                        IconButton(

                          tooltip:
                              "Donner un avis",

                          onPressed:
                              onReview,

                          icon:
                              const Icon(

                                Icons.rate_review_outlined,

                              ),

                        ),


                    ],

                  ),





                  const SizedBox(height: 8),





                  SizedBox(

                    width: double.infinity,


                    child: FilledButton.icon(

                      onPressed:
                          produit.disponible
                              ? onAddCart
                              : null,


                      icon:
                          const Icon(

                            Icons.shopping_cart_outlined,

                          ),


                      label:
                          Text(

                            produit.disponible

                                ? "Ajouter au panier"

                                : "Indisponible",

                          ),

                    ),

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