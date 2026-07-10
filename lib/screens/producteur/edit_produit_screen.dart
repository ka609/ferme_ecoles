import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/produit_provider.dart';


class EditProduitScreen extends StatefulWidget {

  final Map<String,dynamic> produit;


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



  @override
  void initState() {

    super.initState();


    _nomController =
        TextEditingController(
          text:
              widget.produit["nom"],
        );


    _descriptionController =
        TextEditingController(
          text:
              widget.produit["description"],
        );


    _prixController =
        TextEditingController(
          text:
              widget.produit["prix"].toString(),
        );
  }



  @override
  void dispose() {

    _nomController.dispose();

    _descriptionController.dispose();

    _prixController.dispose();

    super.dispose();

  }



  Future<void> _updateProduit() async {


    if(!_formKey.currentState!.validate()){
      return;
    }



    final success =
        await context
            .read<ProduitProvider>()
            .updateProduit(

          widget.produit["id"],

          {

            "nom":
                _nomController.text.trim(),

            "description":
                _descriptionController.text.trim(),

            "prix":
                _prixController.text.trim(),

          },
        );



    if(!mounted) return;



    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content: Text(

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
  Widget build(BuildContext context){

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

              Column(

            children:[


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



              const SizedBox(height:24),



              ElevatedButton(

                onPressed:
                    _updateProduit,


                child:
                    const Text(
                  "Enregistrer",
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}