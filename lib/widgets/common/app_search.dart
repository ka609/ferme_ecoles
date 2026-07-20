import 'package:flutter/material.dart';


class AppSearch extends StatelessWidget {


  final String hint;
  final ValueChanged<String>? onChanged;


  const AppSearch({

    super.key,

    this.hint = "Rechercher un produit...",

    this.onChanged,

  });



  @override
  Widget build(BuildContext context) {


    return TextField(

      onChanged: onChanged,


      decoration: InputDecoration(

        hintText: hint,


        prefixIcon:
        const Icon(Icons.search),


        suffixIcon:
        IconButton(

          icon:
          const Icon(Icons.clear),

          onPressed: () {},

        ),

      ),
    );
  }
}