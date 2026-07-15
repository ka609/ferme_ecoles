import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/formation_provider.dart';


class FormationsProducteurScreen extends StatefulWidget {

  const FormationsProducteurScreen({
    super.key,
  });


  @override
  State<FormationsProducteurScreen> createState() =>
      _FormationsProducteurScreenState();

}




class _FormationsProducteurScreenState
    extends State<FormationsProducteurScreen> {



  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {


      context
          .read<FormationProvider>()
          .fetchFormations();


    });

  }







  Future<void> _refresh() async {

    await context
        .read<FormationProvider>()
        .fetchFormations();

  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Formations",
            ),

      ),





      body: RefreshIndicator(


        onRefresh: _refresh,



        child: Consumer<FormationProvider>(



          builder:
              (context, provider, child) {



            if(provider.isLoading){


              return const Center(

                child:
                    CircularProgressIndicator(),

              );


            }






            if(provider.formations.isEmpty){


              return ListView(

                children: const [

                  SizedBox(
                    height: 250,
                  ),


                  Center(

                    child:
                        Text(
                          "Aucune formation disponible",
                        ),

                  ),

                ],

              );


            }







            return ListView.builder(


              padding:
                  const EdgeInsets.all(16),



              itemCount:
                  provider.formations.length,



              itemBuilder:
                  (context,index){



                final formation =
                    provider.formations[index];







                return Card(


                  margin:
                      const EdgeInsets.only(
                        bottom: 12,
                      ),




                  elevation:
                      2,



                  child: ListTile(




                    leading:

                        Icon(

                      formation.video != null

                          ? Icons.play_circle_outline

                          : formation.document != null

                              ? Icons.picture_as_pdf

                              : Icons.school,

                      size: 40,

                    ),






                    title:
                        Text(

                      formation.titre,

                      maxLines: 1,

                      overflow:
                          TextOverflow.ellipsis,

                    ),








                    subtitle:
                        Column(


                      crossAxisAlignment:
                          CrossAxisAlignment.start,



                      children: [



                        const SizedBox(
                          height: 5,
                        ),





                        Text(

                          formation.description,

                          maxLines: 3,

                          overflow:
                              TextOverflow.ellipsis,

                        ),





                        const SizedBox(
                          height: 8,
                        ),





                        if(formation.auteurNom != null)

                          Text(

                            "Publié par : ${formation.auteurNom}",

                            style:
                                const TextStyle(
                                  fontSize: 12,
                                ),

                          ),






                        if(formation.video != null)

                          const Text(

                            "🎬 Vidéo disponible",

                            style:
                                TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),

                          ),





                        if(formation.document != null)

                          const Text(

                            "📄 Document disponible",

                            style:
                                TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),

                          ),





                      ],

                    ),





                    trailing:
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),





                    onTap: () {


                      _showFormationDetail(
                        context,
                        formation,
                      );


                    },



                  ),


                );


              },


            );


          },


        ),


      ),


    );


  }








  void _showFormationDetail(
    BuildContext context,
    dynamic formation,
  ){


    showDialog(


      context: context,



      builder:
          (context){



        return AlertDialog(


          title:
              Text(
                formation.titre,
              ),



          content:
              SingleChildScrollView(

            child:
                Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,


              children: [


                Text(
                  formation.description,
                ),


                const SizedBox(
                  height: 15,
                ),



                if(formation.video != null)

                  Text(
                    "Lien vidéo : ${formation.video}",
                  ),



                if(formation.document != null)

                  Text(
                    "Document : ${formation.document}",
                  ),



              ],

            ),

          ),




          actions: [


            TextButton(

              onPressed:
                  () => Navigator.pop(context),


              child:
                  const Text(
                    "Fermer",
                  ),

            ),


          ],


        );


      },


    );


  }


}