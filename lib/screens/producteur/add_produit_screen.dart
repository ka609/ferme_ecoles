import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/produit_provider.dart';
import '../../providers/categorie_provider.dart';



class AddProduitScreen extends StatefulWidget {

  const AddProduitScreen({
    super.key,
  });


  @override
  State<AddProduitScreen> createState() =>
      _AddProduitScreenState();

}





class _AddProduitScreenState
    extends State<AddProduitScreen> {


  final _formKey =
      GlobalKey<FormState>();


  final _nomController =
      TextEditingController();


  final _descriptionController =
      TextEditingController();


  final _prixController =
      TextEditingController();


  final _stockController =
      TextEditingController();


  final _uniteController =
      TextEditingController();



  int? _categorieId;


  String? _typeProduit;


  String? _imagePath;



  final List<String> _typesProduits = [

    "PRODUIT_FRAIS",

    "PRODUIT_TRANSFORME",

    "INTRANT_AGROECOLOGIQUE",

  ];







  @override
  void initState() {

    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {


      context
          .read<CategorieProvider>()
          .fetchCategories();


    });

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









  Future<void> _pickImage() async {


    final result =
        await FilePicker.platform.pickFiles(

      type:
          FileType.image,

    );



    if(result != null) {


      setState(() {


        _imagePath =
            result.files.single.path;


      });


    }


  }









  Future<void> _saveProduit() async {


    if(!_formKey.currentState!.validate()) {

      return;

    }




    if(_categorieId == null) {


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text(
                "Veuillez choisir une catégorie",
              ),

        ),

      );


      return;

    }






    if(_typeProduit == null) {


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text(
                "Veuillez choisir le type de produit",
              ),

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



      stock:
          double.parse(
            _stockController.text,
          ),



      unite:
          _uniteController.text.trim(),



      typeProduit:
          _typeProduit!,



      categorieId:
          _categorieId!,



      image:
          _imagePath,


    );







    if(!mounted) return;




    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content:
            Text(

          success
              ? "Produit ajouté"
              : "Erreur ajout produit",

        ),

      ),

    );






    if(success) {

      Navigator.pop(context);

    }


  }









  @override
  Widget build(BuildContext context) {


    final categories =
        context.watch<CategorieProvider>()
            .categories;





    return Scaffold(


      appBar:
          AppBar(

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
                        "Nom du produit",

                    border:
                        OutlineInputBorder(),

                  ),


                  validator:
                      (value) {

                    if(value == null ||
                       value.isEmpty) {

                      return
                          "Champ obligatoire";

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
                        "Stock disponible",

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







                ElevatedButton.icon(

                  onPressed:
                      _pickImage,


                  icon:
                      const Icon(
                        Icons.image,
                      ),


                  label:
                      const Text(
                        "Choisir une image",
                      ),

                ),







                if(_imagePath != null)

                  Padding(

                    padding:
                        const EdgeInsets.only(
                          top: 8,
                        ),


                    child:

                        Text(

                      _imagePath!,

                      overflow:
                          TextOverflow.ellipsis,

                    ),

                  ),







                const SizedBox(height:16),







                DropdownButtonFormField<String>(

                  value:
                      _typesProduits.contains(
                        _typeProduit,
                      )
                          ? _typeProduit
                          : null,


                  decoration:
                      const InputDecoration(

                    labelText:
                        "Type de produit",

                    border:
                        OutlineInputBorder(),

                  ),



                  items:
                      _typesProduits.map(

                    (type) {


                      return DropdownMenuItem<String>(

                        value:
                            type,


                        child:
                            Text(type),

                      );


                    },

                  ).toList(),




                  onChanged:
                      (value) {


                    setState(() {

                      _typeProduit =
                          value;

                    });


                  },


                ),








                const SizedBox(height:16),








                DropdownButtonFormField<int>(


                  value:
                      categories.any(

                    (categorie) =>
                        categorie.id ==
                        _categorieId,

                  )

                      ? _categorieId

                      : null,




                  decoration:
                      const InputDecoration(

                    labelText:
                        "Catégorie",

                    border:
                        OutlineInputBorder(),

                  ),





                  items:
                      categories.map(

                    (categorie) {


                      return DropdownMenuItem<int>(

                        value:
                            categorie.id,


                        child:
                            Text(
                              categorie.nom,
                            ),

                      );


                    },

                  ).toList(),





                  onChanged:
                      (value) {


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

      ),


    );


  }


}