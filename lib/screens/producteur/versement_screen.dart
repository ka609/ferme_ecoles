import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/versement_provider.dart';
import '../../models/versement_model.dart';


class VersementScreen extends StatefulWidget {

  const VersementScreen({
    super.key,
  });


  @override
  State<VersementScreen> createState() =>
      _VersementScreenState();

}



class _VersementScreenState
    extends State<VersementScreen> {


  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<VersementProvider>()
          .fetchVersements();

    });

  }





  Future<void> _refresh() async {

    await context
        .read<VersementProvider>()
        .fetchVersements();

  }





  Color _statutColor(String statut) {

    switch(statut){

      case "PAYE":
        return Colors.green;


      case "EN_ATTENTE":
        return Colors.orange;


      case "ANNULE":
        return Colors.red;


      default:
        return Colors.grey;

    }

  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Mes versements",
            ),

      ),





      body:
          RefreshIndicator(


            onRefresh:
                _refresh,



            child:
                Consumer<VersementProvider>(


                  builder:
                      (
                        context,
                        provider,
                        child,
                      ){



                    if(provider.isLoading){

                      return const Center(

                        child:
                            CircularProgressIndicator(),

                      );

                    }





                    if(provider.versements.isEmpty){

                      return const Center(

                        child:
                            Text(
                              "Aucun versement disponible",
                            ),

                      );

                    }






                    return ListView.builder(


                      padding:
                          const EdgeInsets.all(16),



                      itemCount:
                          provider.versements.length,



                      itemBuilder:
                          (
                            context,
                            index,
                          ){


                        final versement =
                            provider.versements[index];



                        return _VersementCard(

                          versement:
                              versement,


                          statutColor:
                              _statutColor(
                                versement.statut,
                              ),

                        );


                      },


                    );



                  },


                ),

          ),


    );

  }


}







class _VersementCard extends StatelessWidget {


  final Versement versement;

  final Color statutColor;



  const _VersementCard({

    required this.versement,

    required this.statutColor,

  });





  @override
  Widget build(BuildContext context) {


    return Card(


      margin:
          const EdgeInsets.only(
            bottom: 12,
          ),



      child:
          Padding(


            padding:
                const EdgeInsets.all(16),



            child:
                Column(


                  crossAxisAlignment:
                      CrossAxisAlignment.start,



                  children: [




                    Row(

                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,


                      children: [



                        Text(

                          versement.commandeNumero ??
                              "Commande",

                          style:
                              const TextStyle(

                                fontWeight:
                                    FontWeight.bold,

                                fontSize:
                                    16,

                              ),

                        ),





                        Container(

                          padding:
                              const EdgeInsets.symmetric(

                                horizontal: 10,

                                vertical: 5,

                              ),



                          decoration:
                              BoxDecoration(

                                color:
                                    statutColor
                                        .withValues(
                                          alpha:0.15,
                                        ),


                                borderRadius:
                                    BorderRadius.circular(20),

                              ),



                          child:
                              Text(

                                versement.statut,

                                style:
                                    TextStyle(

                                      color:
                                          statutColor,

                                      fontWeight:
                                          FontWeight.bold,

                                      fontSize:
                                          12,

                                    ),

                              ),

                        ),


                      ],

                    ),






                    const SizedBox(
                      height: 15,
                    ),






                    _InfoRow(

                      label:
                          "Montant commande",

                      value:
                          "${versement.montant.toStringAsFixed(0)} FCFA",

                    ),





                    _InfoRow(

                      label:
                          "Commission plateforme",

                      value:
                          "${versement.commissionPlateforme.toStringAsFixed(0)} FCFA",

                    ),





                    const Divider(),





                    _InfoRow(

                      label:
                          "Montant reçu",

                      value:
                          "${versement.montantNet.toStringAsFixed(0)} FCFA",

                      bold:
                          true,

                    ),






                    if(versement.dateVersement != null)

                      _InfoRow(

                        label:
                            "Date versement",

                        value:
                            "${versement.dateVersement!.day}/"
                            "${versement.dateVersement!.month}/"
                            "${versement.dateVersement!.year}",

                      ),




                  ],


                ),

          ),


    );

  }

}






class _InfoRow extends StatelessWidget {


  final String label;

  final String value;

  final bool bold;



  const _InfoRow({

    required this.label,

    required this.value,

    this.bold = false,

  });





  @override
  Widget build(BuildContext context) {


    return Padding(

      padding:
          const EdgeInsets.symmetric(
            vertical: 5,
          ),



      child:
          Row(

            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,


            children: [


              Text(label),



              Text(

                value,

                style:
                    TextStyle(

                      fontWeight:
                          bold
                              ? FontWeight.bold
                              : FontWeight.normal,

                    ),

              ),


            ],

          ),

    );

  }

}