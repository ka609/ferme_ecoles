import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/avis_provider.dart';
import '../../models/produit_model.dart';


class AvisScreen extends StatefulWidget {

  final Produit produit;


  const AvisScreen({

    super.key,

    required this.produit,

  });



  @override
  State<AvisScreen> createState() => _AvisScreenState();

}




class _AvisScreenState extends State<AvisScreen> {


  final TextEditingController _commentaireController =
      TextEditingController();


  int _note = 5;



  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {

      context
          .read<AvisProvider>()
          .fetchAvis(
            produitId: widget.produit.id,
          );

    });

  }




  @override
  void dispose() {

    _commentaireController.dispose();

    super.dispose();

  }





  Future<void> _envoyerAvis() async {


    if(_commentaireController.text.trim().isEmpty){

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content:
              Text(
                "Veuillez saisir un commentaire",
              ),

        ),

      );

      return;

    }



    final success =
        await context
            .read<AvisProvider>()
            .createAvis(

              produitId: widget.produit.id,

              note: _note,

              commentaire:
                  _commentaireController.text.trim(),

            );



    if(success && mounted){


      _commentaireController.clear();


      setState(() {

        _note = 5;

      });



      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content:
              Text(
                "Avis ajouté avec succès",
              ),

        ),

      );


    }


  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            Text(
              "Avis - ${widget.produit.nom}",
            ),

      ),




      body: Consumer<AvisProvider>(


        builder:
            (context, provider, child){


          return RefreshIndicator(


            onRefresh: () async {

              await provider.fetchAvis(

                produitId: widget.produit.id,

              );

            },



            child: ListView(

              padding:
                  const EdgeInsets.all(16),



              children: [





                // FORMULAIRE AVIS

                Card(

                  child: Padding(

                    padding:
                        const EdgeInsets.all(16),


                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,


                      children: [



                        const Text(

                          "Donner votre avis",

                          style:
                              TextStyle(

                                fontSize: 18,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                        ),



                        const SizedBox(height: 12),





                        Row(

                          children:

                              List.generate(

                                5,

                                (index){


                                  final star =
                                      index + 1;



                                  return IconButton(

                                    onPressed: (){

                                      setState(() {

                                        _note = star;

                                      });

                                    },


                                    icon:

                                      Icon(

                                        Icons.star,

                                        color:

                                          star <= _note

                                              ? Colors.amber

                                              : Colors.grey,

                                      ),

                                  );


                                },

                              ),

                        ),





                        TextField(

                          controller:
                              _commentaireController,


                          maxLines: 4,


                          decoration:
                              const InputDecoration(

                                labelText:
                                    "Votre commentaire",

                                border:
                                    OutlineInputBorder(),

                              ),

                        ),





                        const SizedBox(height: 12),





                        SizedBox(

                          width:
                              double.infinity,


                          child:
                              FilledButton.icon(

                                onPressed:

                                    provider.isLoading

                                        ? null

                                        : _envoyerAvis,


                                icon:
                                    const Icon(
                                      Icons.send,
                                    ),


                                label:
                                    const Text(
                                      "Publier l'avis",
                                    ),

                              ),

                        ),


                      ],

                    ),

                  ),

                ),







                const SizedBox(height: 20),





                const Text(

                  "Avis des clients",

                  style:
                      TextStyle(

                        fontSize: 18,

                        fontWeight:
                            FontWeight.bold,

                      ),

                ),





                const SizedBox(height: 10),







                if(provider.isLoading)

                  const Center(

                    child:
                        CircularProgressIndicator(),

                  )





                else if(provider.avis.isEmpty)

                  const Center(

                    child:
                        Padding(

                          padding:
                              EdgeInsets.all(30),


                          child:
                              Text(
                                "Aucun avis pour ce produit",
                              ),

                        ),

                  )





                else


                  ...provider.avis.map(

                    (avis){


                      return Card(


                        margin:
                            const EdgeInsets.only(
                              bottom: 10,
                            ),


                        child:
                            ListTile(


                              leading:
                                  CircleAvatar(

                                    child:
                                        Text(

                                          avis.note
                                              .toString(),

                                        ),

                                  ),



                              title:
                                  Text(

                                    avis.clientNom ??
                                        "Client",

                                  ),



                              subtitle:
                                  Column(

                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,


                                    children: [


                                      Row(

                                        children:

                                            List.generate(

                                              5,

                                              (index){

                                                return Icon(

                                                  Icons.star,

                                                  size: 16,

                                                  color:

                                                      index < avis.note

                                                          ? Colors.amber

                                                          : Colors.grey,

                                                );

                                              },

                                            ),

                                      ),



                                      const SizedBox(height: 5),



                                      Text(
                                        avis.commentaire,
                                      ),


                                    ],

                                  ),


                            ),


                      );


                    },

                  ),



              ],

            ),

          );


        },

      ),

    );

  }

}