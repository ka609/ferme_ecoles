import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';

import '../../models/user_enum.dart';
import '../../models/produit_model.dart';
import '../../models/sujet_forum_model.dart';

import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';

import '../../screens/public/catalog_screen.dart';
import '../../screens/public/produit_detail_screen.dart';

import '../../screens/client/panier_screen.dart';
import '../../screens/client/paiement_screen.dart';
import '../../screens/client/commande_screen.dart';
import '../../screens/client/suivi_commande_screen.dart';

import '../../screens/shared/profile_screen.dart';
import '../../screens/shared/notification_screen.dart';
import '../../screens/shared/forum_screen.dart';
import '../../screens/shared/sujet_forum_detail_screen.dart';
import '../../screens/shared/creer_sujet_screen.dart';
import '../../screens/shared/reponses_forum_screen.dart';

import '../../screens/livreur/livreur_home.dart';
import '../../screens/livreur/livraison_disponible_screen.dart';
import '../../screens/livreur/mes_livraisons_screen.dart';
import '../../screens/livreur/livraison_detail_screen.dart';
import '../../screens/producteur/producteur_dashboard_screen.dart';


GoRouter createRouter(AuthProvider auth) {

  return GoRouter(

    initialLocation: "/catalogue",

    refreshListenable: auth,


    redirect: (context, state) {

      final isLogged =
          auth.isAuthenticated;


      final user =
          auth.user;


      final location =
          state.matchedLocation;



      final publicRoutes = [

        "/catalogue",
        "/login",
        "/register",

      ];



      final isPublic =
          publicRoutes.any(
            (route) =>
                location.startsWith(route),
          );



      if (!isLogged) {

        return isPublic
            ? null
            : "/login";

      }



      if (location == "/login" ||
          location == "/register") {


        switch(user?.role) {


          case UserRole.producteur:

            return "/producteur/dashboard";


          case UserRole.livreur:

            return "/livreur";


          case UserRole.client:

            return "/catalogue";


          case UserRole.admin:

            return "/catalogue";


          default:

            return "/catalogue";

        }

      }


      return null;

    },


    routes: [


      // Public

      GoRoute(
        path: "/catalogue",
        builder: (context, state) =>
            const CatalogScreen(),
      ),


      GoRoute(
        path: "/produit/:id",

        builder: (context, state) {

          final produit =
              state.extra as Produit;


          return ProduitDetailScreen(
            produit: produit,
          );

        },
      ),



      // Auth

      GoRoute(
        path: "/login",
        builder: (context, state) =>
            const LoginScreen(),
      ),


      GoRoute(
        path: "/register",
        builder: (context, state) =>
            const RegisterScreen(),
      ),



      // Client

      GoRoute(
        path: "/panier",
        builder: (context, state) =>
            const PanierScreen(),
      ),


      GoRoute(
        path: "/paiement",
        builder: (context, state) =>
            const PaiementScreen(),
      ),


      GoRoute(
        path: "/commandes",
        builder: (context, state) =>
            const CommandeScreen(),
      ),


      GoRoute(
        path: "/livraisons",
        builder: (context, state) =>
            const SuiviCommandeScreen(),
      ),



      // Producteur

      GoRoute(
        path: "/producteur/dashboard",
       builder: (context, state) =>
           const ProducteurDashboard(),
),


      // Livreur

      GoRoute(
        path: "/livreur",

        builder: (context, state) =>
            const LivreurHome(),

      ),


      GoRoute(
        path: "/livreur/livraisons-disponibles",

        builder: (context, state) =>
            const LivraisonDisponibleScreen(),

      ),


      GoRoute(
        path: "/livreur/mes-livraisons",

        builder: (context, state) =>
            const MesLivraisonsScreen(),

      ),


      GoRoute(
        path: "/livreur/livraison/:id",

        builder: (context, state) {

          final id =
              int.parse(
                state.pathParameters["id"]!,
              );


          return LivraisonDetailScreen(
            livraisonId: id,
          );

        },

      ),



      // Shared

      GoRoute(
        path: "/profile",

        builder: (context, state) =>
            const ProfileScreen(),

      ),


      GoRoute(
        path: "/notifications",

        builder: (context, state) =>
            const NotificationScreen(),

      ),


      GoRoute(
        path: "/forum",

        builder: (context, state) =>
            const ForumScreen(),

      ),


      GoRoute(
        path: "/forum/nouveau",

        builder: (context, state) =>
            const CreerSujetScreen(),

      ),


      GoRoute(
        path: "/forum/:id",

        builder: (context, state) {

          final sujet =
              state.extra as SujetForum;


          return SujetForumDetailScreen(
            sujet: sujet,
          );

        },

      ),


      GoRoute(
        path: "/forum/:id/reponses",

        builder: (context, state) {

          final sujet =
              state.extra as SujetForum;


          return ReponsesForumScreen(
            sujet: sujet,
          );

        },

      ),

    ],


    errorBuilder: (context, state) {

      return Scaffold(

        body: Center(

          child: Text(
            "Page introuvable : ${state.uri}",
          ),

        ),

      );

    },

  );

}