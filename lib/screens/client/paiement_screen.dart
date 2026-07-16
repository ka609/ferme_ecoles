import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/commande_model.dart';
import '../../providers/paiement_provider.dart';


class PaiementScreen extends StatefulWidget {

  final Commande commande;


  const PaiementScreen({

    super.key,

    required this.commande,

  });



  @override
  State<PaiementScreen> createState() =>
      _PaiementScreenState();

}




class _PaiementScreenState
    extends State<PaiementScreen> {


  String _moyen = "Mobile Money";


  final TextEditingController _referenceController =
      TextEditingController();



  final List<String> _moyens = [

    "Mobile Money",

    "Espèces",

    "Virement",

  ];





  bool _isSubmitting = false;





  Future<void> _validerPaiement() async {


    setState(() {

      _isSubmitting = true;

    });



    final success =
        await context
            .read<PaiementProvider>()
            .createPaiement(

              commandeId:
                  widget.commande.id,


              montant:
                  widget.commande.montantTotal,


              moyen:
                  _moyen,


              reference:
                  _referenceController.text
                          .trim()
                          .isEmpty

                      ? null

                      : _referenceController.text.trim(),

            );




    setState(() {

      _isSubmitting = false;

    });





    if(!mounted) return;





    if(success){


      ScaffoldMessenger.of(context)
          .showSnackBar(

            const SnackBar(

              content:
                  Text(
                    "Paiement enregistré avec succès",
                  ),

            ),

          );



      Navigator.pop(context);



    }else{


      ScaffoldMessenger.of(context)
          .showSnackBar(

            SnackBar(

              content:
                  Text(

                    context
                        .read<PaiementProvider>()
                        .error ??
                        "Erreur paiement",

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
            const Text(
              "Paiement",
            ),

      ),





      body: Padding(

        padding:
            const EdgeInsets.all(16),



        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,



          children: [





            Card(

              child:
                  Padding(

                    padding:
                        const EdgeInsets.all(16),


                    child:
                        Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,


                          children: [


                            Text(

                              "Commande : ${widget.commande.numero}",


                              style:
                                  const TextStyle(

                                    fontWeight:
                                        FontWeight.bold,

                                  ),

                            ),



                            const SizedBox(
                              height: 8,
                            ),



                            Text(

                              "Montant : ${widget.commande.montantTotal.toStringAsFixed(0)} FCFA",

                              style:
                                  const TextStyle(

                                    fontSize: 18,

                                    fontWeight:
                                        FontWeight.bold,

                                  ),

                            ),


                          ],

                        ),

                  ),

            ),





            const SizedBox(
              height: 20,
            ),





            const Text(

              "Choisir le moyen de paiement",

              style:
                  TextStyle(

                    fontSize: 16,

                    fontWeight:
                        FontWeight.bold,

                  ),

            ),






            const SizedBox(
              height: 10,
            ),





            ..._moyens.map(

              (moyen) {


                return RadioListTile<String>(

                  value:
                      moyen,


                  groupValue:
                      _moyen,


                  title:
                      Text(moyen),



                  onChanged:
                      (value){


                        setState(() {

                          _moyen =
                              value!;

                        });


                      },

                );


              },

            ),







            const SizedBox(
              height: 10,
            ),






            TextField(

              controller:
                  _referenceController,


              decoration:
                  const InputDecoration(

                    labelText:
                        "Référence transaction (optionnel)",


                    hintText:
                        "Ex: TX123456",

                    border:
                        OutlineInputBorder(),

                  ),

            ),







            const Spacer(),






            SizedBox(

              width:
                  double.infinity,


              child:
                  FilledButton.icon(

                    onPressed:
                        _isSubmitting
                            ? null
                            : _validerPaiement,



                    icon:
                        _isSubmitting

                            ? const SizedBox(

                                height:18,

                                width:18,

                                child:
                                    CircularProgressIndicator(
                                      strokeWidth:2,
                                    ),

                              )

                            : const Icon(
                                Icons.payment,
                              ),



                    label:
                        Text(

                          _isSubmitting

                              ? "Validation..."

                              : "Valider le paiement",

                        ),

                  ),

            ),



          ],

        ),

      ),

    );

  }





  @override
  void dispose(){

    _referenceController.dispose();

    super.dispose();

  }


}