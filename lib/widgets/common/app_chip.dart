import 'package:flutter/material.dart';


class AppChip extends StatelessWidget {


  final String label;
  final Color? color;


  const AppChip({

    super.key,

    required this.label,

    this.color,

  });



  @override
  Widget build(BuildContext context) {


    return Chip(

      label:
      Text(label),


      backgroundColor:
      color ??
      Theme.of(context)
          .colorScheme
          .primary
          .withOpacity(.15),


    );
  }
}