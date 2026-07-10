import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/produit_provider.dart';
import '../../providers/statistique_provider.dart';

import '../../widgets/produit_card.dart';


class ProducteurDashboard extends StatefulWidget {
  const ProducteurDashboard({
    super.key,
  });


  @override
  State<ProducteurDashboard> createState() =>
      _ProducteurDashboardState();
}



class _ProducteurDashboardState
    extends State<ProducteurDashboard> {


  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<ProduitProvider>()
          .fetchMesProduits();


      context
          .read<StatistiqueProvider>()
          .fetchStatistiqueProducteur();

    });
  }



  Future<void> _supprimerProduit(
      int id,
  ) async {

    final success =
        await context
            .read<ProduitProvider>()
            .deleteProduit(id);


    if (!mounted) return;


    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          success
              ? "Produit supprimé"
              : "Erreur suppression",
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title:
            const Text(
          "Espace producteur",
        ),

        actions: [

          IconButton(
            icon:
                const Icon(
              Icons.notifications,
            ),

            onPressed: () {},
          ),


          IconButton(
            icon:
                const Icon(
              Icons.person,
            ),

            onPressed: () {

              Navigator.pushNamed(
                context,
                "/profile",
              );

            },
          ),
        ],
      ),



      floatingActionButton:
          FloatingActionButton(

        onPressed: () {
          // ajouter produit
        },


        child:
            const Icon(
          Icons.add,
        ),
      ),



      body:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(16),


        child:

            Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [


            // Statistiques
            const Text(
              "Résumé activité",
              style:
                  TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),


            const SizedBox(height: 12),


            _dashboardCard(
              icon: Icons.bar_chart,
              title:
                  "Statistiques producteur",
              onTap: () {

                Navigator.pushNamed(
                  context,
                  "/statistiques",
                );

              },
            ),



            const SizedBox(height: 20),



            // Produits
            const Text(
              "Mes produits",
              style:
                  TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),



            const SizedBox(height: 12),



            Consumer<ProduitProvider>(
              
              builder:
                  (context, provider, child) {


                if(provider.isLoading){

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );

                }


                if(provider.mesProduits.isEmpty){

                  return const Text(
                    "Aucun produit enregistré",
                  );

                }


                return Column(

                  children:

                      provider.mesProduits
                          .map(

                    (produit) {


                      return Card(

                        margin:
                            const EdgeInsets.only(
                          bottom: 12,
                        ),


                        child:
                            Column(

                          children:[


                            ProduitCard(
                              produit:
                                  produit,

                              onTap: () {},
                            ),


                            Row(

                              mainAxisAlignment:
                                  MainAxisAlignment.end,


                              children:[


                                IconButton(

                                  icon:
                                      const Icon(
                                    Icons.edit,
                                  ),

                                  onPressed: () {},
                                ),



                                IconButton(

                                  icon:
                                      const Icon(
                                    Icons.delete,
                                  ),

                                  onPressed: () {

                                    _supprimerProduit(
                                      produit.id,
                                    );

                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );

                    },

                  ).toList(),

                );
              },
            ),



            const SizedBox(height:20),



            // Autres modules
            const Text(
              "Gestion",
              style:
                  TextStyle(
                fontSize:18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),



            _dashboardCard(
              icon:
                  Icons.verified,

              title:
                  "Certification BIO SPG",

              onTap: () {

                Navigator.pushNamed(
                  context,
                  "/certification",
                );

              },
            ),



            _dashboardCard(
              icon:
                  Icons.shopping_cart,

              title:
                  "Commandes",

              onTap: () {},
            ),



            _dashboardCard(
              icon:
                  Icons.local_shipping,

              title:
                  "Livraisons",

              onTap: () {},
            ),

          ],
        ),
      ),
    );
  }



  Widget _dashboardCard({

    required IconData icon,

    required String title,

    required VoidCallback onTap,

  }) {

    return Card(

      child:
          ListTile(

        leading:
            Icon(icon),


        title:
            Text(title),


        trailing:
            const Icon(
          Icons.arrow_forward_ios,
        ),


        onTap:
            onTap,

      ),
    );
  }
}