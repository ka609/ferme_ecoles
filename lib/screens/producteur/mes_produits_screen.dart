import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../core/routes/app_routes.dart';

import '../../providers/produit_provider.dart';
import '../../providers/categorie_provider.dart';

import '../../widgets/produit_card.dart';


class MesProduitsScreen extends StatefulWidget {

  const MesProduitsScreen({
    super.key,
  });


  @override
  State<MesProduitsScreen> createState() =>
      _MesProduitsScreenState();

}



class _MesProduitsScreenState
    extends State<MesProduitsScreen> {



  final _nomCategorieController =
      TextEditingController();


  final _descriptionCategorieController =
      TextEditingController();



  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<ProduitProvider>()
          .fetchMesProduits();


      context
          .read<CategorieProvider>()
          .fetchCategories();

    });

  }



  @override
  void dispose() {

    _nomCategorieController.dispose();

    _descriptionCategorieController.dispose();

    super.dispose();

  }




  Future<void> _ajouterCategorie() async {


    if(_nomCategorieController.text.trim().isEmpty){

      return;

    }



    final success =
        await context
            .read<CategorieProvider>()
            .createCategorie(

          nom:
              _nomCategorieController.text.trim(),


          description:
              _descriptionCategorieController.text.trim(),

        );



    if(!mounted) return;



    Navigator.pop(context);



    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content: Text(

          success
              ? "Catégorie ajoutée"
              : "Erreur ajout catégorie",

        ),

      ),

    );



    _nomCategorieController.clear();

    _descriptionCategorieController.clear();

  }




  void _showCategorieDialog(){


    showDialog(

      context: context,

      builder:(context){


        return AlertDialog(

          title:
              const Text(
                "Ajouter une catégorie",
              ),


          content:

              Column(

                mainAxisSize:
                    MainAxisSize.min,


                children:[


                  TextField(

                    controller:
                        _nomCategorieController,


                    decoration:
                        const InputDecoration(

                      labelText:
                          "Nom catégorie",

                      border:
                          OutlineInputBorder(),

                    ),

                  ),



                  const SizedBox(height:16),



                  TextField(

                    controller:
                        _descriptionCategorieController,


                    maxLines:
                        3,


                    decoration:
                        const InputDecoration(

                      labelText:
                          "Description",

                      border:
                          OutlineInputBorder(),

                    ),

                  ),


                ],

              ),



          actions:[


            TextButton(

              onPressed:(){

                Navigator.pop(context);

              },

              child:
                  const Text(
                    "Annuler",
                  ),

            ),



            ElevatedButton(

              onPressed:
                  _ajouterCategorie,


              child:
                  const Text(
                    "Ajouter",
                  ),

            ),


          ],


        );


      },

    );


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
              : "Erreur lors de la suppression",

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
              "Mes produits",
            ),



        actions:[


          IconButton(

            icon:
                const Icon(
                  Icons.category_outlined,
                ),


            tooltip:
                "Ajouter une catégorie",


            onPressed:
                _showCategorieDialog,

          ),


        ],

      ),





      floatingActionButton:
          FloatingActionButton(


        onPressed:(){


          context.push(AppRoutes.producteurAjouterProduit);


        },


        child:
            const Icon(
              Icons.add,
            ),


      ),





      body:

          RefreshIndicator(


        onRefresh:() async{


          await context
              .read<ProduitProvider>()
              .fetchMesProduits();


        },



        child:

            Consumer<ProduitProvider>(


          builder:(context,provider,child){



            if(provider.isLoading){

              return const Center(

                child:
                    CircularProgressIndicator(),

              );

            }




            if(provider.mesProduits.isEmpty){


              return const Center(

                child:
                    Text(
                      "Aucun produit disponible",
                    ),

              );


            }





            return ListView.builder(


              padding:
                  const EdgeInsets.all(16),



              itemCount:
                  provider.mesProduits.length,



              itemBuilder:(context,index){


                final produit =
                    provider.mesProduits[index];



                return ProduitCard(


                  produit:
                      produit,



                  onTap:(){


                    Navigator.pushNamed(

                      context,

                      AppRoutes.producteurAjouterProduit.replaceFirst(':id', produit.id.toString()),

                      arguments:
                          produit,

                    );


                  },



                  actions:[


                    IconButton(

                      icon:
                          const Icon(
                            Icons.edit,
                          ),


                      onPressed:(){


                        Navigator.pushNamed(

                          context,

                          AppRoutes.producteurModifierProduit.replaceFirst(':id', produit.id.toString()),

                          arguments:
                              produit,

                        );


                      },


                    ),




                    IconButton(

                      icon:
                          const Icon(
                            Icons.delete,
                          ),


                      onPressed:(){


                        _supprimerProduit(
                          produit.id,
                        );


                      },


                    ),



                  ],


                );


              },


            );


          },


        ),


      ),


    );


  }


}