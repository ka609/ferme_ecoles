import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/produit_provider.dart';


class AddProduitScreen extends StatefulWidget {
  const AddProduitScreen({super.key});

  @override
  State<AddProduitScreen> createState() =>
      _AddProduitScreenState();
}


class _AddProduitScreenState
    extends State<AddProduitScreen> {

  final _formKey = GlobalKey<FormState>();

  final _nomController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prixController = TextEditingController();

  int? _categorieId;


  @override
  void dispose() {

    _nomController.dispose();
    _descriptionController.dispose();
    _prixController.dispose();

    super.dispose();
  }



  Future<void> _saveProduit() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }


    if (_categorieId == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text("Veuillez choisir une catégorie"),
        ),
      );

      return;
    }



    final success =
        await context
            .read<ProduitProvider>()
            .createProduit(

          nom:
              _nomController.text.trim(),

          description:
              _descriptionController.text.trim(),

          prix:
              double.parse(
                _prixController.text,
              ),

          categorieId:
              _categorieId!,
        );



    if (!mounted) return;


    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          success
              ? "Produit ajouté"
              : "Erreur ajout produit",
        ),
      ),
    );


    if (success) {

      Navigator.pop(context);

    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text(
          "Ajouter un produit",
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

            children: [

              TextFormField(

                controller:
                    _nomController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Nom du produit",
                  border:
                      OutlineInputBorder(),
                ),

                validator:
                    (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return "Champ obligatoire";
                  }

                  return null;
                },
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

                validator:
                    (value){

                  if(value == null ||
                     value.isEmpty){

                    return "Prix obligatoire";
                  }

                  return null;
                },
              ),



              const SizedBox(height:16),



              DropdownButtonFormField<int>(

                value:
                    _categorieId,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Catégorie",
                  border:
                      OutlineInputBorder(),
                ),


                items: const [

                  DropdownMenuItem(
                    value:1,
                    child:
                        Text("Légumes"),
                  ),

                  DropdownMenuItem(
                    value:2,
                    child:
                        Text("Fruits"),
                  ),

                ],


                onChanged:
                    (value){

                  setState(() {

                    _categorieId =
                        value;

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
                      _saveProduit,


                  child:
                      const Text(
                    "Ajouter",
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}