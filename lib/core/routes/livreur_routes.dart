import 'package:go_router/go_router.dart';


import '../../screens/livreur/livreur_shell.dart';
import '../../screens/livreur/livreur_home.dart';
import '../../screens/livreur/livraison_disponible_screen.dart';
import '../../screens/livreur/mes_livraisons_screen.dart';
import '../../screens/livreur/livraison_detail_screen.dart';


import '../../screens/shared/profile_screen.dart';


import 'app_routes.dart';



final List<RouteBase> livreurRoutes = [



  // --------------------------------------------------
  // Livreur Shell : navigation persistante BottomBar
  // --------------------------------------------------

  StatefulShellRoute.indexedStack(

    builder: (
      context,
      state,
      navigationShell,
    ){

      return LivreurShell(

        navigationShell: navigationShell,

      );

    },


    branches: [



      // ----------------------------------------------
      // Onglet 0 : Accueil livreur
      // ----------------------------------------------

      StatefulShellBranch(

        routes: [

          GoRoute(

            path: AppRoutes.livreur,


            builder: (
              context,
              state,
            ){

              return const LivreurHome();

            },

          ),

        ],

      ),





      // ----------------------------------------------
      // Onglet 1 : Livraisons disponibles
      // ----------------------------------------------

      StatefulShellBranch(

        routes: [

          GoRoute(

            path: AppRoutes.livraisonsDisponibles,


            builder: (
              context,
              state,
            ){

              return const LivraisonDisponibleScreen();

            },

          ),

        ],

      ),





      // ----------------------------------------------
      // Onglet 2 : Mes livraisons
      // ----------------------------------------------

      StatefulShellBranch(

        routes: [

          GoRoute(

            path: AppRoutes.mesLivraisons,


            builder: (
              context,
              state,
            ){

              return const MesLivraisonsScreen();

            },

          ),

        ],

      ),





      // ----------------------------------------------
      // Onglet 3 : Profil
      // ----------------------------------------------

      StatefulShellBranch(

        routes: [

          GoRoute(

            path: AppRoutes.livreurProfil,


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
  // Détail d'une livraison
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.livraisonDetail,


    builder: (
      context,
      state,
    ){


      final id =
          int.parse(
            state.pathParameters["id"]!,
          );



      return LivraisonDetailScreen(

        livraisonId: id,

      );


    },

  ),


];