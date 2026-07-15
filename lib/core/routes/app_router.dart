import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../providers/auth_provider.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';


import 'app_routes.dart';
import 'route_guard.dart';


import 'client_routes.dart';
import 'producteur_routes.dart';
import 'livreur_routes.dart';
import 'shared_routes.dart';



GoRouter createRouter(
  AuthProvider auth,
) {


  return GoRouter(


    // Page affichée au lancement
    initialLocation: AppRoutes.catalogue,


    // Permet au routeur de réagir aux changements
    // de connexion/déconnexion
    refreshListenable: auth,



    // Gestion authentification + redirection selon rôle
    redirect: (
      context,
      state,
    ){

      return RouteGuard.redirect(
        auth,
        state,
      );

    },



    routes: [


      // Routes client
      ...clientRoutes,


      // Routes producteur
      ...producteurRoutes,


      // Routes livreur
      ...livreurRoutes,


      // Routes communes
      ...sharedRoutes,


      // ------------------------------------------------
      // Authentification
      // ------------------------------------------------

      GoRoute(

        path: AppRoutes.login,


        builder: (
          context,
          state,
        ){

          return const LoginScreen();

        },

      ),


      GoRoute(

        path: AppRoutes.register,


        builder: (
          context,
          state,
        ){

          return const RegisterScreen();

        },

      ),


    ],






    // Page erreur
    errorBuilder: (
      context,
      state,
    ){


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