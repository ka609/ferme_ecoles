import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/produit_provider.dart';
import '../../models/produit_model.dart';


class EditProduitScreen extends StatefulWidget {

  final Produit produit;


  const EditProduitScreen({
    super.key,
    required this.produit,
  });


  @override
  State<EditProduitScreen> createState() =>
      _EditProduitScreenState();

}




class _EditProduitScreenState
    extends State<EditProduitScreen> {


  final _formKey =
      GlobalKey<FormState>();


  late TextEditingController _nomController;

  late TextEditingController _descriptionController;

  late TextEditingController _prixController;

  late TextEditingController _stockController;

  late TextEditingController _uniteController;



  String? _typeProduit;



  final List<String> _typesProduits = [

    "PRODUIT_FRAIS",

    "PRODUIT_TRANSFORME",

    "INTRANT_AGROECOLOGIQUE",

  ];






  @override
  void initState() {

    super.initState();



    _nomController =
        TextEditingController(
          text: widget.produit.nom,
        );



    _descriptionController =
        TextEditingController(
          text: widget.produit.description ?? "",
        );



    _prixController =
        TextEditingController(
          text: widget.produit.prix.toString(),
        );



    _stockController =
        TextEditingController(
          text: widget.produit.stock.toString(),
        );



    _uniteController =
        TextEditingController(
          text: widget.produit.unite,
        );



    _typeProduit =
        widget.produit.typeProduit;


  }







  @override
  void dispose() {


    _nomController.dispose();

    _descriptionController.dispose();

    _prixController.dispose();

    _stockController.dispose();

    _uniteController.dispose();


    super.dispose();

  }








  Future<void> _updateProduit() async {


    if (!_formKey.currentState!.validate()) {

      return;

    }




    final success =
        await context
            .read<ProduitProvider>()
            .updateProduit(


      widget.produit.id,



      {


        "nom":
            _nomController.text.trim(),



        "description":
            _descriptionController.text.trim(),



        "prix":
            double.parse(
              _prixController.text,
            ),



        "stock":
            double.parse(
              _stockController.text,
            ),



        "unite":
            _uniteController.text.trim(),



        "type_produit":
            _typeProduit,



      },

    );







    if (!mounted) return;





    ScaffoldMessenger.of(context)
        .showSnackBar(


      SnackBar(

        content:
            Text(

          success
              ? "Produit modifié"
              : "Erreur modification",

        ),

      ),


    );






    if(success){

      Navigator.pop(context);

    }


  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(



      appBar:
          AppBar(

        title:
            const Text(
              "Modifier produit",
            ),

      ),





      body:


          Padding(

        padding:
            const EdgeInsets.all(16),




        child:


            Form(

          key:
              _formKey,



          child:


              SingleChildScrollView(



            child:


                Column(



              children: [





                TextFormField(

                  controller:
                      _nomController,


                  decoration:
                      const InputDecoration(

                    labelText:
                        "Nom",

                    border:
                        OutlineInputBorder(),

                  ),

                ),






                const SizedBox(height:16),






                TextFormField(

                  controller:
                      _descriptionController,


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






                const SizedBox(height:16),






                TextFormField(

                  controller:
                      _prixController,


                  keyboardType:
                      TextInputType.number,


                  decoration:
                      const InputDecoration(

                    labelText:
                        "Prix",

                    border:
                        OutlineInputBorder(),

                  ),

                ),






                const SizedBox(height:16),






                TextFormField(

                  controller:
                      _stockController,


                  keyboardType:
                      TextInputType.number,


                  decoration:
                      const InputDecoration(

                    labelText:
                        "Stock",

                    border:
                        OutlineInputBorder(),

                  ),

                ),






                const SizedBox(height:16),






                TextFormField(

                  controller:
                      _uniteController,


                  decoration:
                      const InputDecoration(

                    labelText:
                        "Unité (kg, litre, sac...)",

                    border:
                        OutlineInputBorder(),

                  ),

                ),






                const SizedBox(height:16),






                DropdownButtonFormField<String>(
  value: _typesProduits.contains(_typeProduit)
      ? _typeProduit
      : null,

  decoration: const InputDecoration(
    labelText: "Type de produit",
    border: OutlineInputBorder(),
  ),

  items: _typesProduits.map(
    (type) {
      return DropdownMenuItem<String>(
        value: type,
        child: Text(type),
      );
    },
  ).toList(),

  onChanged: (value) {
    setState(() {
      _typeProduit = value;
    });
  },
),







                const SizedBox(height:24),








                SizedBox(

                  width:
                      double.infinity,



                  child:


                      ElevatedButton(


                    onPressed:
                        _updateProduit,


                    child:
                        const Text(
                          "Enregistrer",
                        ),


                  ),


                ),



              ],


            ),


          ),

        ),

      ),


    );

  }

}