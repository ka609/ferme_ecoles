import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/produit_model.dart';
import '../../providers/auth_provider.dart';


class ProduitDetailScreen extends StatelessWidget {


  final Produit produit;


  const ProduitDetailScreen({
    super.key,
    required this.produit,
  });



  @override
  Widget build(BuildContext context) {


    final isLogged =
        context.watch<AuthProvider>()
            .isAuthenticated;



    return Scaffold(



      appBar: AppBar(

        title:
            const Text(
              "Détail du produit",
            ),


      ),




      body: SafeArea(

        child: CustomScrollView(

          slivers:[




            // Images produit

            SliverToBoxAdapter(

              child:SizedBox(

                height:280,


                child:

                produit.images.isNotEmpty


                ?

                PageView.builder(

                  itemCount:
                      produit.images.length,


                  itemBuilder:(context,index){


                    return Image.network(

                      produit.images[index].image,

                      width:
                          double.infinity,

                      fit:
                          BoxFit.cover,

                    );


                  },

                )



                :

                produit.image != null


                ?

                Image.network(

                  produit.image!,

                  width:
                      double.infinity,

                  fit:
                      BoxFit.cover,

                )


                :

                Container(

                  color:
                      Colors.grey.shade200,


                  child:
                      const Icon(

                    Icons.image_outlined,

                    size:
                        80,

                  ),

                ),

              ),

            ),





            SliverPadding(

              padding:
                  const EdgeInsets.all(16),


              sliver:

              SliverToBoxAdapter(

                child:

                Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,


                  children:[




                    Text(

                      produit.nom,

                      style:
                          const TextStyle(

                        fontSize:
                            24,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),




                    const SizedBox(height:12),





                    Row(

                      children:[


                        Text(

                          "${produit.prix.toStringAsFixed(0)} FCFA",

                          style:
                              const TextStyle(

                            fontSize:
                                20,

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),


                        const SizedBox(width:10),



                        Text(

                          "/ ${produit.unite}",

                          style:
                              TextStyle(

                            color:
                                Colors.grey.shade700,

                          ),

                        ),


                      ],

                    ),






                    const SizedBox(height:20),





                    _InfoCard(

                      title:
                          "Catégorie",

                      value:
                          produit.categorieNom ??
                          "Non définie",

                      icon:
                          Icons.category_outlined,

                    ),





                    _InfoCard(

                      title:
                          "Type de produit",

                      value:
                          produit.typeProduit,

                      icon:
                          Icons.eco_outlined,

                    ),






                    _InfoCard(

                      title:
                          "Stock disponible",

                      value:
                          "${produit.stock} ${produit.unite}",

                      icon:
                          Icons.inventory_2_outlined,

                    ),





                    const SizedBox(height:20),






                    const Text(

                      "Description",

                      style:
                          TextStyle(

                        fontSize:
                            18,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),





                    const SizedBox(height:8),




                    Text(

                      produit.description ??
                          "Aucune description disponible.",

                    ),







                    const SizedBox(height:20),






                    const Text(

                      "Producteur",

                      style:
                          TextStyle(

                        fontSize:
                            18,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),




                    const SizedBox(height:8),





                    Text(

                      produit.producteurNom ??
                          "Producteur inconnu",

                    ),





                    const SizedBox(height:20),







                    Container(

                      width:
                          double.infinity,


                      padding:
                          const EdgeInsets.all(14),


                      decoration:

                      BoxDecoration(

                        borderRadius:
                            BorderRadius.circular(12),


                        color:

                        produit.valide

                        ?

                        Colors.green.shade50

                        :

                        Colors.orange.shade50,

                      ),



                      child:

                      Row(

                        children:[


                          Icon(

                            produit.valide

                            ?

                            Icons.verified

                            :

                            Icons.pending,

                          ),



                          const SizedBox(width:10),




                          Expanded(

                            child:

                            Text(

                              produit.valide

                              ?

                              "Produit validé BIO SPG"

                              :

                              "Produit en attente de validation",

                            ),

                          ),

                        ],

                      ),

                    ),




                    const SizedBox(height:20),




                    Row(

                      children:[



                        Icon(

                          produit.disponible

                          ?

                          Icons.check_circle

                          :

                          Icons.cancel,


                        ),



                        const SizedBox(width:8),




                        Text(

                          produit.disponible

                          ?

                          "Disponible"

                          :

                          "Indisponible",

                        ),

                      ],

                    ),





                  ],

                ),

              ),

            ),


          ],

        ),

      ),





      bottomNavigationBar:

      SafeArea(

        child:

        Padding(

          padding:
              const EdgeInsets.all(16),



          child:

          SizedBox(

            height:
                50,



            width:
                double.infinity,



            child:

            ElevatedButton.icon(

              icon:
                  const Icon(
                    Icons.shopping_cart_outlined,
                  ),


              label:

              const Text(
                "Ajouter au panier",
              ),



              onPressed:(){



                if(!isLogged){


                  context.push(
                    "/login",
                  );


                  return;

                }



                // TODO:
                // Appeler PanierProvider.addProduit()



                ScaffoldMessenger.of(context)
                    .showSnackBar(

                  const SnackBar(

                    content:
                        Text(
                          "Produit ajouté au panier",
                        ),

                  ),

                );


              },

            ),

          ),

        ),

      ),


    );


  }

}




class _InfoCard extends StatelessWidget {


  final String title;

  final String value;

  final IconData icon;



  const _InfoCard({

    required this.title,

    required this.value,

    required this.icon,

  });



  @override
  Widget build(BuildContext context){


    return Container(

      margin:
          const EdgeInsets.only(bottom:12),


      padding:
          const EdgeInsets.all(12),



      decoration:

      BoxDecoration(

        border:

        Border.all(
          color:
              Colors.grey.shade300,
        ),


        borderRadius:
            BorderRadius.circular(12),

      ),




      child:

      Row(

        children:[


          Icon(icon),


          const SizedBox(width:12),


          Expanded(

            child:

            Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children:[


                Text(

                  title,

                  style:
                      const TextStyle(

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),



                Text(value),



              ],

            ),

          ),


        ],

      ),

    );


  }


}