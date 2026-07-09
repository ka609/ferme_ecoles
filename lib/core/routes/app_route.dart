import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

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


final GoRouter appRouter = GoRouter(
  initialLocation: "/catalogue",

  redirect: (context, state) {

    final auth = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final isLogged = auth.isAuthenticated;
    final location = state.matchedLocation;


    final publicRoutes = [
      "/catalogue",
      "/login",
      "/register",
    ];


    final isPublic =
        publicRoutes.contains(location);


    // Protection routes privées
    if (!isLogged) {
      return isPublic ? null : "/login";
    }


    // Redirection après connexion
    if (location == "/login" ||
        location == "/register") {

      return "/catalogue";
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