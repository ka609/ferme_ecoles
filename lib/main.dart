import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

import 'core/routes/app_route.dart';



void main() {

  runApp(
    const FermeEcoleApp(),
  );

}



class FermeEcoleApp extends StatelessWidget {

  const FermeEcoleApp({
    super.key,
  });



  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [


        // Authentification
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),




        // Catalogue
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



        // Commandes
        ChangeNotifierProvider(
          create: (_) => PanierProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CommandeProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => PaiementProvider(),
        ),



        // Livraison
        ChangeNotifierProvider(
          create: (_) => LivraisonProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CommissionProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => SocieteLivraisonProvider(),
        ),



        // Communauté
        ChangeNotifierProvider(
          create: (_) => AvisProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => SujetForumProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ReponseForumProvider(),
        ),



        // Formation
        ChangeNotifierProvider(
          create: (_) => FormationProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => SuiviFormationProvider(),
        ),



        // Administration
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

      ],


      child: MaterialApp.router(

        debugShowCheckedModeBanner: false,

        title: "Ferme École Intégrée",

        routerConfig: appRouter,

      ),

    );

  }

}