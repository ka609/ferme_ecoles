import 'package:flutter/material.dart';

import '../models/panier_article_model.dart';
import 'common/app_card.dart';


class PanierArticleCard extends StatelessWidget {

  final PanierArticle article;

  final VoidCallback? onDelete;

  final VoidCallback? onIncrease;

  final VoidCallback? onDecrease;


  const PanierArticleCard({

    super.key,

    required this.article,

    this.onDelete,

    this.onIncrease,

    this.onDecrease,

  });



  @override
  Widget build(BuildContext context) {


    return AppCard(

      margin: const EdgeInsets.only(
        bottom: 12,
      ),


      child: Row(

        children: [


          CircleAvatar(

            backgroundColor:
                Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.12),


            child: Icon(

              Icons.shopping_basket_outlined,

              color:
                  Theme.of(context)
                      .colorScheme
                      .primary,

            ),

          ),



          const SizedBox(width: 12),





          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,


              children: [



                Text(

                  article.produitNom ??
                      "Produit",

                  style:
                      const TextStyle(

                        fontWeight:
                            FontWeight.bold,

                        fontSize: 16,

                      ),

                ),



                const SizedBox(height: 6),




                Text(

                  "${article.prix.toStringAsFixed(0)} FCFA / unité",

                  style:
                      Theme.of(context)
                          .textTheme
                          .bodyMedium,

                ),





                Text(

                  "Sous-total : ${article.sousTotal.toStringAsFixed(0)} FCFA",

                  style:
                      const TextStyle(

                        fontWeight:
                            FontWeight.w600,

                      ),

                ),





                Row(

                  children: [



                    IconButton(

                      onPressed:
                          onDecrease,

                      icon:
                          const Icon(
                            Icons.remove_circle_outline,
                          ),

                    ),





                    Text(

                      "${article.quantite}",

                      style:
                          const TextStyle(

                            fontSize: 16,

                            fontWeight:
                                FontWeight.bold,

                          ),

                    ),





                    IconButton(

                      onPressed:
                          onIncrease,

                      icon:
                          const Icon(
                            Icons.add_circle_outline,
                          ),

                    ),



                  ],

                ),



              ],

            ),

          ),





          IconButton(

            onPressed:
                onDelete,


            icon:
                const Icon(

                  Icons.delete_outline,

                  color: Colors.red,

                ),

          ),


        ],

      ),

    );


  }

}