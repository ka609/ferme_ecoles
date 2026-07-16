import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/sujet_forum_model.dart';
import '../../models/produit_model.dart';

import '../../screens/shared/profile_screen.dart';
import '../../screens/shared/notification_screen.dart';
import '../../screens/shared/forum_screen.dart';
import '../../screens/shared/creer_sujet_screen.dart';
import '../../screens/shared/sujet_forum_detail_screen.dart';
import '../../screens/shared/reponses_forum_screen.dart';
import '../../screens/public/avis_screen.dart';

import 'app_routes.dart';



final List<RouteBase> sharedRoutes = [



  // --------------------------------------------------
  // Profil utilisateur
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.profile,

    builder: (
      context,
      state,
    ){

      return const ProfileScreen();

    },

  ),






  // --------------------------------------------------
  // Notifications
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.notifications,

    builder: (
      context,
      state,
    ){

      return const NotificationScreen();

    },

  ),






  // --------------------------------------------------
  // Forum
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.forum,

    builder: (
      context,
      state,
    ){

      return const ForumScreen();

    },

  ),






  // --------------------------------------------------
  // Création d'un sujet forum
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.nouveauSujet,

    builder: (
      context,
      state,
    ){

      return const CreerSujetScreen();

    },

  ),







  // --------------------------------------------------
  // Détail d'un sujet forum
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.sujetDetail,

    builder: (
      context,
      state,
    ){


      final sujet = state.extra;



      if(sujet is! SujetForum){


        return const Scaffold(

          body: Center(

            child: Text(
              "Sujet introuvable",
            ),

          ),

        );

      }




      return SujetForumDetailScreen(

        sujet: sujet,

      );


    },

  ),







  // --------------------------------------------------
  // Réponses d'un sujet forum
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.reponsesForum,

    builder: (
      context,
      state,
    ){


      final sujet = state.extra;



      if(sujet is! SujetForum){


        return const Scaffold(

          body: Center(

            child: Text(
              "Sujet introuvable",
            ),

          ),

        );

      }




      return ReponsesForumScreen(

        sujet: sujet,

      );


    },

  ),

  GoRoute(

  path: AppRoutes.avisProduit,

  builder: (
    context,
    state,
  ){

    final produit = state.extra;


    if(produit is! Produit){

      return const Scaffold(

        body: Center(

          child: Text(
            "Produit introuvable",
          ),

        ),

      );

    }


    return AvisScreen(

      produit: produit,

    );

  },

),



];