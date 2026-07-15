import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/produit_model.dart';
import '../../models/commande_model.dart';

import '../../screens/public/catalog_screen.dart';
import '../../screens/public/produit_detail_screen.dart';

import '../../screens/client/client_shell.dart';
import '../../screens/client/panier_screen.dart';
import '../../screens/client/commande_screen.dart';
import '../../screens/client/suivi_commande_screen.dart';
import '../../screens/client/commande_detail_screen.dart';

import '../../screens/shared/profile_screen.dart';

import 'app_routes.dart';



final List<RouteBase> clientRoutes = [



  // --------------------------------------------------
  // Client Shell : navigation persistante BottomBar
  // --------------------------------------------------

  StatefulShellRoute.indexedStack(

    builder: (
      context,
      state,
      navigationShell,
    ) {

      return ClientShell(
        navigationShell: navigationShell,
      );

    },


    branches: [



      // ----------------------------------------------
      // Onglet 0 : Catalogue
      // ----------------------------------------------

      StatefulShellBranch(

        routes: [

          GoRoute(

            path: AppRoutes.catalogue,

            builder: (
              context,
              state,
            ){

              return const CatalogScreen();

            },

          ),

        ],

      ),





      // ----------------------------------------------
      // Onglet 1 : Commandes
      // ----------------------------------------------

      StatefulShellBranch(

        routes: [

          GoRoute(

            path: AppRoutes.commandes,

            builder: (
              context,
              state,
            ){

              return const CommandeScreen();

            },

          ),

        ],

      ),





      // ----------------------------------------------
      // Onglet 2 : Suivi livraison
      // ----------------------------------------------

      StatefulShellBranch(

        routes: [

          GoRoute(

            path: AppRoutes.livraisons,

            builder: (
              context,
              state,
            ){

              return const SuiviCommandeScreen();

            },

          ),

        ],

      ),





      // ----------------------------------------------
      // Onglet 3 : Profil client
      // ----------------------------------------------

      StatefulShellBranch(

        routes: [

          GoRoute(

            path: AppRoutes.clientProfil,

            builder: (
              context,
              state,
            ){

              return const ProfileScreen();

            },

          ),

        ],

      ),


    ],

  ),








  // --------------------------------------------------
  // Détail commande
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.commandeDetail,

    builder: (
      context,
      state,
    ){


      final commande = state.extra;



      if(commande is! Commande){


        return const Scaffold(

          body: Center(

            child: Text(
              "Commande introuvable",
            ),

          ),

        );

      }




      return CommandeDetailScreen(

        commande: commande,

      );


    },

  ),








  // --------------------------------------------------
  // Détail produit
  // --------------------------------------------------

  GoRoute(

    path: "${AppRoutes.produit}/:id",

    builder: (
      context,
      state,
    ){


      final produit =
          state.extra as Produit;



      return ProduitDetailScreen(

        produit: produit,

      );


    },

  ),







  // --------------------------------------------------
  // Panier
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.panier,

    builder: (
      context,
      state,
    ){

      return const PanierScreen();

    },

  ),


];