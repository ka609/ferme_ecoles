import 'package:flutter/material.dart';


class AppSectionTitle extends StatelessWidget {


  final String title;
  final String? action;
  final VoidCallback? onTap;


  const AppSectionTitle({

    super.key,

    required this.title,

    this.action,

    this.onTap,

  });



  @override
  Widget build(BuildContext context) {


    return Row(

      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,


      children: [


        Text(

          title,

          style:
          Theme.of(context)
              .textTheme
              .titleLarge,

        ),


        if(action != null)

          TextButton(

            onPressed:onTap,

            child:
            Text(action!),

          ),

      ],

    );
  }
}