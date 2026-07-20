import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';


class StatusBadge extends StatelessWidget {

  final String statut;


  const StatusBadge({
    super.key,
    required this.statut,
  });



  static const Map<String, Color> _colors = {

    // Commandes
    'LIVREE': Colors.green,
    'VALIDEE': Colors.green,

    'EN_COURS': Colors.blue,
    'PREPARATION': Colors.blue,
    'EXPEDIEE': Colors.blue,

    'EN_ATTENTE': Colors.orange,

    'ANNULEE': Colors.red,
    'REFUSEE': Colors.red,


    // Paiements

    'PAYE': Colors.green,
    'IMPAYE': Colors.red,
    'REMBOURSE': Colors.purple,


    // Produits

    'DISPONIBLE': Colors.green,
    'RUPTURE': Colors.red,


    // Certification BIO

    'CERTIFIE': Colors.green,
    'NON_CERTIFIE': Colors.orange,

  };




  static const Map<String, String> _labels = {


    // Commandes

    'LIVREE': 'Livrée',
    'VALIDEE': 'Validée',

    'EN_COURS': 'En cours',
    'PREPARATION': 'Préparation',
    'EXPEDIEE': 'Expédiée',

    'EN_ATTENTE': 'En attente',

    'ANNULEE': 'Annulée',
    'REFUSEE': 'Refusée',



    // Paiements

    'PAYE': 'Payé',
    'IMPAYE': 'Impayé',
    'REMBOURSE': 'Remboursé',



    // Produits

    'DISPONIBLE': 'Disponible',
    'RUPTURE': 'Rupture',



    // BIO

    'CERTIFIE': 'BIO certifié',
    'NON_CERTIFIE': 'Non certifié',

  };




  @override
  Widget build(BuildContext context) {


    final key = statut
        .toUpperCase()
        .replaceAll(' ', '_');



    final Color color =
        _colors[key] ?? AppTheme.textSecondary;



    final String label =
        _labels[key] ?? statut;



    return Container(

      padding:
      const EdgeInsets.symmetric(

        horizontal: 12,

        vertical: 6,

      ),


      decoration:

      BoxDecoration(

        color:

        color.withOpacity(.12),


        borderRadius:

        BorderRadius.circular(20),


      ),



      child:

      Text(

        label,


        style:

        TextStyle(

          color: color,

          fontSize: 12,

          fontWeight:

          FontWeight.w600,

        ),

      ),

    );

  }

}