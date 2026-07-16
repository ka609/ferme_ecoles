import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../providers/panier_provider.dart';

import '../../widgets/panier_article_card.dart';
import '../../widgets/common/empty_state.dart';

import '../../core/routes/app_routes.dart';


class PanierDetailScreen extends StatefulWidget {

  final int panierId;


  const PanierDetailScreen({
    super.key,
    required this.panierId,
  });



  @override
  State<PanierDetailScreen> createState() =>
      _PanierDetailScreenState();

}





class _PanierDetailScreenState
    extends State<PanierDetailScreen> {



  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {


      context
          .read<PanierProvider>()
          .fetchPanierDetail(
            widget.panierId,
          );


    });

  }








  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title:
            const Text(
              "Détail du panier",
            ),

      ),






      body: Consumer<PanierProvider>(


        builder:
            (
              context,
              panierProvider,
              child,
            ) {



          if(panierProvider.isLoading){


            return const Center(

              child:
                  CircularProgressIndicator(),

            );

          }








          final panier =
              panierProvider.detail;







          if(panier == null){


            return const EmptyState(

              icon:
                  Icons.shopping_cart_outlined,


              message:
                  "Panier introuvable",

            );

          }








          final articles =
              panier.articles;







          if(articles.isEmpty){


            return const EmptyState(

              icon:
                  Icons.remove_shopping_cart_outlined,


              message:
                  "Ce panier ne contient aucun article",

            );

          }









          return Column(


            children: [





              Padding(

                padding:
                    const EdgeInsets.all(16),



                child: Card(


                  child: ListTile(


                    leading:
                        const CircleAvatar(

                      child:
                          Icon(
                            Icons.person,
                          ),

                    ),






                    title: Text(

                      panier.producteurNom ??
                      "Producteur",

                    ),






                    subtitle: Text(

                      "${articles.length} article(s)",

                    ),


                  ),


                ),


              ),







              Expanded(


                child: ListView.builder(


                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),



                  itemCount:
                      articles.length,



                  itemBuilder:
                      (context,index){



                    final article =
                        articles[index];






                    return PanierArticleCard(

                      article:
                          article,



                      onDelete: () {


                        // suppression à gérer via PanierArticleProvider
                        // ou directement via PanierService

                      },


                    );


                  },

                ),


              ),









              Container(


                padding:
                    const EdgeInsets.all(16),




                decoration:
                    BoxDecoration(


                      border:

                          Border(

                            top: BorderSide(

                              color:
                                  Colors.grey.shade300,

                            ),

                          ),


                    ),








                child: Column(


                  children: [





                    Row(

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

                          "${_calculerTotal(articles)} FCFA",



                          style:
                              const TextStyle(

                                fontSize: 18,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                        ),



                      ],


                    ),







                    const SizedBox(height:16),









                    SizedBox(

                      width:
                          double.infinity,



                      child:
                          ElevatedButton(


                            onPressed: () {


                              context.push(

                                AppRoutes.paiement,

                              );


                            },



                            child:
                                const Text(

                                  "Passer au paiement",

                                ),


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









  double _calculerTotal(
    List articles,
  ){


    return articles.fold(

      0,

      (total, article){



        return total + article.sousTotal;


      },

    );


  }


}