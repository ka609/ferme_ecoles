import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/panier_article_provider.dart';
import '../../widgets/panier_article_card.dart';
import '../../widgets/common/empty_state.dart';


class PanierArticlesScreen extends StatefulWidget {

  final int panierId;

  const PanierArticlesScreen({
    super.key,
    required this.panierId,
  });


  @override
  State<PanierArticlesScreen> createState() =>
      _PanierArticlesScreenState();

}



class _PanierArticlesScreenState
    extends State<PanierArticlesScreen> {



  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<PanierArticleProvider>()
          .fetchArticles();

    });

  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title:
            const Text(
              "Contenu du panier",
            ),

      ),




      body: Consumer<PanierArticleProvider>(


        builder:
            (
              context,
              provider,
              child,
            ) {



          if(provider.isLoading){

            return const Center(

              child:
                  CircularProgressIndicator(),

            );

          }





          if(provider.articles.isEmpty){

            return const EmptyState(

              icon:
                  Icons.remove_shopping_cart_outlined,

              message:
                  "Aucun article dans ce panier",

            );

          }





          return Column(

            children: [



              Expanded(

                child: ListView.builder(

                  padding:
                      const EdgeInsets.all(16),


                  itemCount:
                      provider.articles.length,



                  itemBuilder:
                      (context,index){



                    final article =
                        provider.articles[index];



                    return PanierArticleCard(

                      article:
                          article,


                      onDelete: (){

                        provider.supprimerArticle(
                          article.id,
                        );

                      },


                      onIncrease: (){


                        provider.modifierQuantite(

                          articleId:
                              article.id,

                          quantite:
                              article.quantite + 1,

                        );


                      },



                      onDecrease: (){


                        if(article.quantite > 1){

                          provider.modifierQuantite(

                            articleId:
                                article.id,

                            quantite:
                                article.quantite - 1,

                          );

                        }


                      },

                    );


                  },

                ),

              ),





              Container(

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

                            fontSize:18,

                            fontWeight:
                                FontWeight.bold,

                          ),

                    ),




                    Text(

                      "${provider.total.toStringAsFixed(0)} FCFA",

                      style:
                          const TextStyle(

                            fontSize:18,

                            fontWeight:
                                FontWeight.bold,

                          ),

                    ),



                  ],

                ),

              ),



            ],

          );



        },


      ),

    );


  }

}