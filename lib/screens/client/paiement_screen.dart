import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/paiement_provider.dart';

class PaiementScreen extends StatefulWidget {
  const PaiementScreen({super.key});

  @override
  State<PaiementScreen> createState() =>
      _PaiementScreenState();
}


class _PaiementScreenState extends State<PaiementScreen> {

  String _modePaiement = "MOBILE_MONEY";


  bool _loading = false;


  Future<void> _payer() async {

    setState(() {
      _loading = true;
    });


    final paiement =
        await context
            .read<PaiementProvider>()
            .createPaiement(
              commandeId: 1, // Replace with actual commande ID
              montant: 10000, // Replace with actual amount
              moyen: _modePaiement,
            );


    if (!mounted) return;


    setState(() {
      _loading = false;
    });



    if (paiement) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text(
            "Paiement effectué avec succès",
          ),
        ),

      );


      context.go("/commandes");


    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text(
            "Échec du paiement",
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



      body:
          Padding(

        padding:
            const EdgeInsets.all(16),


        child:
            Column(

          crossAxisAlignment:
              CrossAxisAlignment.stretch,


          children: [


            const Text(

              "Choisir le mode de paiement",

              style:
                  TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),


            const SizedBox(height: 20),



            RadioListTile<String>(

              value:
                  "MOBILE_MONEY",

              groupValue:
                  _modePaiement,


              title:
                  const Text(
                "Mobile Money",
              ),


              onChanged:
                  (value) {

                setState(() {

                  _modePaiement =
                      value!;

                });
              },
            ),



            RadioListTile<String>(

              value:
                  "ESPECES",


              groupValue:
                  _modePaiement,


              title:
                  const Text(
                "Paiement à la livraison",
              ),


              onChanged:
                  (value) {

                setState(() {

                  _modePaiement =
                      value!;

                });

              },
            ),



            const Spacer(),



            ElevatedButton(

              onPressed:
                  _loading
                      ? null
                      : _payer,


              child:

                  _loading

                      ? const SizedBox(

                          height: 22,

                          width: 22,

                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )

                      :

                        const Text(
                          "Valider le paiement",
                        ),
            ),
          ],
        ),
      ),
    );
  }
}