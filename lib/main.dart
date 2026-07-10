import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';

import 'providers/auth_provider.dart';

import 'providers/catalog_provider.dart';
import 'providers/categorie_provider.dart';
import 'providers/produit_provider.dart';
import 'providers/certification_provider.dart';
import 'providers/produit_image_provider.dart';

import 'providers/avis_provider.dart';
import 'providers/commande_provider.dart';
import 'providers/commission_provider.dart';
import 'providers/formation_provider.dart';
import 'providers/journal_activite_provider.dart';
import 'providers/livraison_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/paiement_provider.dart';
import 'providers/panier_provider.dart';
import 'providers/parametre_provider.dart';
import 'providers/producteur_provider.dart';
import 'providers/reponse_forum_provider.dart';
import 'providers/societe_livraison_provider.dart';
import 'providers/suivi_formation_provider.dart';
import 'providers/sujet_forum_provider.dart';
import 'providers/versement_provider.dart';
import 'providers/statistique_provider.dart';

import 'core/routes/app_route.dart';

void main() {

  final authProvider = AuthProvider();

  runApp(
    FermeEcoleApp(
      authProvider: authProvider,
    ),
  );

}


class FermeEcoleApp extends StatelessWidget {

  final AuthProvider authProvider;

  const FermeEcoleApp({
    super.key,
    required this.authProvider,
  });


  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        ChangeNotifierProvider.value(
          value: authProvider,
        ),


        ChangeNotifierProvider(
          create: (_) => CatalogProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CategorieProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ProduitProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CertificationProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ProduitImageProvider(),
        ),


        ChangeNotifierProvider(
          create: (_) => PanierProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CommandeProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => PaiementProvider(),
        ),


        ChangeNotifierProvider(
          create: (_) => LivraisonProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CommissionProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => SocieteLivraisonProvider(),
        ),


        ChangeNotifierProvider(
          create: (_) => AvisProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => SujetForumProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ReponseForumProvider(),
        ),


        ChangeNotifierProvider(
          create: (_) => FormationProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => SuiviFormationProvider(),
        ),


        ChangeNotifierProvider(
          create: (_) => ProducteurProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => JournalActiviteProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ParametreProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => VersementProvider(),
        ),

        ChangeNotifierProvider(
      create: (_) => StatistiqueProvider(),
    ),

      ],


      child: MaterialApp.router(

        debugShowCheckedModeBanner: false,

        title: "Ferme École Intégrée",
        theme: AppTheme.light,

        routerConfig: createRouter(
          authProvider,
        ),

      ),

    );

  }

}