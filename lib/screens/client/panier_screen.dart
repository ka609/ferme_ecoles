import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../core/routes/app_routes.dart';

import '../../providers/panier_provider.dart';
import '../../widgets/panier_article_card.dart';


class PanierScreen extends StatefulWidget {
  const PanierScreen({super.key});

  @override
  State<PanierScreen> createState() => _PanierScreenState();
}


class _PanierScreenState extends State<PanierScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PanierProvider>().fetchPanier();
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Mon panier",
        ),
      ),


      body: Consumer<PanierProvider>(

        builder: (context, panier, child) {


          if (panier.isLoading) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          if (panier.articles.isEmpty) {

            return const Center(
              child: Text(
                "Votre panier est vide",
              ),
            );
          }


          return Column(

            children: [

              Expanded(

                child: ListView.builder(

                  padding:
                      const EdgeInsets.all(16),


                  itemCount:
                      panier.articles.length,


                  itemBuilder:
                      (context, index) {

                    final article =
                        panier.articles[index];


                    return PanierArticleCard(
                      article: article,

                      onDelete: () {

                        panier.supprimerArticle(
                          article.id,
                        );

                      },
                    );
                  },
                ),
              ),



              Container(

                padding:
                    const EdgeInsets.all(16),


                decoration: BoxDecoration(

                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),


                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,


                  children: [

                    Row(

                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,


                      children: [

                        const Text(
                          "Total",
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),


                        Text(

                          "${panier.total} FCFA",

                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(height: 16),


                    ElevatedButton(

                      onPressed: () {

                        context.push(
                          AppRoutes.paiement,
                        );

                      },


                      child: const Text(
                        "Passer la commande",
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