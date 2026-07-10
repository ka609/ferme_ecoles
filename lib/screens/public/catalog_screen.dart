import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/catalog_provider.dart';
import '../../providers/categorie_provider.dart';

import '../../models/produit_model.dart';

import '../../widgets/produit_card.dart';
import '../../widgets/categorie_card.dart';


class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() =>
      _CatalogScreenState();
}


class _CatalogScreenState extends State<CatalogScreen> {

  int _currentIndex = 0;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<CatalogProvider>()
          .fetchProduits();

      context
          .read<CategorieProvider>()
          .fetchCategories();

    });
  }



  void _changePage(int index) {

    setState(() {
      _currentIndex = index;
    });


    switch(index) {

      case 1:
        context.go("/commandes");
        break;


      case 2:
        context.go("/livraisons");
        break;


      case 3:
        context.go("/profile");
        break;

    }

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "FERME-ÉCOLE",
        ),


        actions: [

          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
            ),

            onPressed: () {
              context.go("/notifications");
            },
          ),


          IconButton(
            icon: const Icon(
              Icons.forum_outlined,
            ),

            onPressed: () {
              context.go("/forum");
            },
          ),


          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),

            onPressed: () {
              context.go("/panier");
            },
          ),

        ],

      ),



      body: SafeArea(

        child: RefreshIndicator(

          onRefresh: () async {

            await context
                .read<CatalogProvider>()
                .fetchProduits();

          },


          child: CustomScrollView(

            physics:
                const AlwaysScrollableScrollPhysics(),


            slivers: [


              // Recherche
              SliverPadding(

                padding:
                    const EdgeInsets.all(16),


                sliver:
                    SliverToBoxAdapter(

                  child:
                      TextField(

                    decoration:
                        InputDecoration(

                      hintText:
                          "Rechercher un produit",


                      prefixIcon:
                          const Icon(
                            Icons.search,
                          ),


                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                              12,
                            ),

                      ),

                    ),

                  ),

                ),

              ),




              // Catégories
              SliverPadding(

                padding:
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),


                sliver:
                    SliverToBoxAdapter(

                  child:
                      Consumer<CategorieProvider>(

                    builder:
                        (context, provider, child) {


                      if(provider.categories.isEmpty) {

                        return const SizedBox(
                          height:1
                        );

                      }


                      return SizedBox(

                        height: 90,


                        child:
                            ListView.builder(

                          scrollDirection:
                              Axis.horizontal,


                          itemCount:
                              provider.categories.length,


                          itemBuilder:
                              (context, index) {


                            return CategorieCard(

                              categorie:
                                  provider.categories[index],

                            );

                          },

                        ),

                      );

                    },

                  ),

                ),

              ),




              // Produits
              Consumer<CatalogProvider>(

                builder:
                    (context, provider, child) {


                  if(provider.isLoading) {

                    return const SliverToBoxAdapter(

                      child:
                          Center(

                        child:
                            CircularProgressIndicator(),

                      ),

                    );

                  }



                  if(provider.produits.isEmpty) {

                    return const SliverToBoxAdapter(

                      child:
                          Center(

                        child:
                            Padding(

                          padding:
                              EdgeInsets.all(20),

                          child:
                              Text(
                                "Aucun produit disponible",
                              ),

                        ),

                      ),

                    );

                  }



                  return SliverPadding(

                    padding:
                        const EdgeInsets.all(16),


                    sliver:
                        SliverGrid(

                      delegate:
                          SliverChildBuilderDelegate(

                        (context, index) {


                          final Produit produit =
                              provider.produits[index];



                          return ProduitCard(

                            produit:
                                produit,


                            onTap: () {

                              context.go(

                                "/produit/${produit.id}",

                                extra:
                                    produit,

                              );

                            },

                          );

                        },


                        childCount:
                            provider.produits.length,

                      ),



                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount:
                            2,


                        crossAxisSpacing:
                            12,


                        mainAxisSpacing:
                            12,


                        childAspectRatio:
                            0.70,

                      ),

                    ),

                  );

                },

              ),


            ],

          ),

        ),

      ),




      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex:
            _currentIndex,


        onTap:
            _changePage,


        type:
            BottomNavigationBarType.fixed,


        items: const [

          BottomNavigationBarItem(

            icon:
                Icon(
                  Icons.storefront_outlined,
                ),

            label:
                "Catalogue",

          ),


          BottomNavigationBarItem(

            icon:
                Icon(
                  Icons.receipt_long_outlined,
                ),

            label:
                "Commandes",

          ),


          BottomNavigationBarItem(

            icon:
                Icon(
                  Icons.local_shipping_outlined,
                ),

            label:
                "Livraison",

          ),


          BottomNavigationBarItem(

            icon:
                Icon(
                  Icons.person_outline,
                ),

            label:
                "Compte",

          ),

        ],

      ),

    );

  }

}