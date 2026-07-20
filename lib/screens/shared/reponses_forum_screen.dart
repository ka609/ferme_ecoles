import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/sujet_forum_model.dart';
import '../../providers/reponse_forum_provider.dart';


class ReponsesForumScreen extends StatefulWidget {

  final SujetForum sujet;


  const ReponsesForumScreen({
    super.key,
    required this.sujet,
  });


  @override
  State<ReponsesForumScreen> createState() =>
      _ReponsesForumScreenState();

}



class _ReponsesForumScreenState
    extends State<ReponsesForumScreen> {


  final _controller =
      TextEditingController();



  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<ReponseForumProvider>()
          .fetchReponses(
            widget.sujet.id,
          );

    });

  }



  @override
  void dispose() {

    _controller.dispose();

    super.dispose();

  }



  Future<void> _envoyer() async {

    final message =
        _controller.text.trim();


    if(message.isEmpty){
      return;
    }



    await context
        .read<ReponseForumProvider>()
        .createReponse(

          sujetId: widget.sujet.id,

          contenu: message,

        );



    _controller.clear();



    await context
        .read<ReponseForumProvider>()
        .fetchReponses(
          widget.sujet.id,
        );

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Discussion",
            ),

        centerTitle:true,

      ),



      body: SafeArea(


        child: Column(

          children: [



            // SUJET

            Container(

              width:double.infinity,

              margin:
                  const EdgeInsets.all(16),


              padding:
                  const EdgeInsets.all(18),


              decoration:BoxDecoration(

                color:
                    Colors.green.shade50,


                borderRadius:
                    BorderRadius.circular(20),

              ),


              child:Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children:[


                  Row(

                    children:[

                      const Icon(
                        Icons.forum,
                        color:Colors.green,
                      ),


                      const SizedBox(
                        width:10,
                      ),


                      Expanded(

                        child:Text(

                          widget.sujet.titre,

                          maxLines:2,

                          overflow:
                              TextOverflow.ellipsis,


                          style:
                              const TextStyle(

                                fontSize:18,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                        ),

                      ),

                    ],

                  ),



                  const SizedBox(
                    height:12,
                  ),



                  Text(

                    widget.sujet.contenu,

                    maxLines:4,

                    overflow:
                        TextOverflow.ellipsis,

                    style:
                        const TextStyle(
                          height:1.5,
                        ),

                  ),


                ],

              ),

            ),





            // REPONSES

            Expanded(

              child:

              Consumer<ReponseForumProvider>(

                builder:
                    (context,provider,child){



                  if(provider.reponses.isEmpty){

                    return const Center(

                      child:Column(

                        mainAxisSize:
                            MainAxisSize.min,


                        children:[

                          Icon(
                            Icons.chat_bubble_outline,
                            size:60,
                            color:Colors.grey,
                          ),


                          SizedBox(
                            height:12,
                          ),


                          Text(
                            "Aucune réponse",
                          ),

                        ],

                      ),

                    );

                  }



                  return ListView.builder(

                    padding:
                        const EdgeInsets.symmetric(
                          horizontal:16,
                        ),


                    itemCount:
                        provider.reponses.length,


                    itemBuilder:
                        (context,index){


                      final reponse =
                          provider.reponses[index];



                      return Container(

                        margin:
                            const EdgeInsets.only(
                              bottom:12,
                            ),


                        padding:
                            const EdgeInsets.all(16),


                        decoration:
                            BoxDecoration(

                              color:
                                  Theme.of(context)
                                      .cardColor,


                              borderRadius:
                                  BorderRadius.circular(18),


                              boxShadow:[

                                BoxShadow(

                                  color:
                                      Colors.black
                                          .withOpacity(0.05),

                                  blurRadius:8,

                                  offset:
                                      const Offset(0,3),

                                ),

                              ],

                            ),


                        child:Row(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,


                          children:[


                            CircleAvatar(

                              backgroundColor:
                                  Colors.green.shade100,


                              child:
                                  Icon(

                                    Icons.person,

                                    color:
                                        Colors.green.shade700,

                                  ),

                            ),



                            const SizedBox(
                              width:12,
                            ),



                            Expanded(

                              child:Text(

                                reponse.contenu,

                                style:
                                    const TextStyle(

                                      fontSize:15,

                                      height:1.5,

                                    ),

                              ),

                            ),

                          ],

                        ),

                      );

                    },

                  );

                },

              ),

            ),






            // SAISIE REPONSE

            Container(

              padding:
                  const EdgeInsets.fromLTRB(
                    16,
                    10,
                    16,
                    16,
                  ),


              decoration:
                  BoxDecoration(

                    color:
                        Theme.of(context)
                            .scaffoldBackgroundColor,


                    boxShadow:[

                      BoxShadow(

                        color:
                            Colors.black
                                .withOpacity(0.05),

                        blurRadius:10,

                        offset:
                            const Offset(0,-3),

                      ),

                    ],

                  ),



              child:Row(

                children:[



                  Expanded(

                    child:

                    TextField(

                      controller:
                          _controller,


                      maxLines:3,

                      minLines:1,


                      decoration:
                          InputDecoration(

                            hintText:
                                "Écrire une réponse...",


                            filled:true,


                            fillColor:
                                Colors.grey.shade100,


                            border:
                                OutlineInputBorder(

                                  borderRadius:
                                      BorderRadius.circular(24),


                                  borderSide:
                                      BorderSide.none,

                                ),

                          ),

                    ),

                  ),



                  const SizedBox(
                    width:10,
                  ),



                  CircleAvatar(

                    radius:24,


                    child:
                        IconButton(

                          icon:
                              const Icon(
                                Icons.send,
                              ),


                          onPressed:
                              _envoyer,

                        ),

                  ),

                ],

              ),

            ),



          ],

        ),

      ),

    );

  }

}