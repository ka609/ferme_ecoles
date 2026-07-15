import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../models/user_enum.dart';

import 'app_routes.dart';
import 'route_utils.dart';



class RouteGuard {


  static String? redirect(
    AuthProvider auth,
    GoRouterState state,
  ){


    final logged =
        auth.isAuthenticated;


    final user =
        auth.user;


    final location =
        state.matchedLocation;



    // -------------------------------
    // Routes publiques
    // -------------------------------

    final publicRoutes = [

      AppRoutes.catalogue,
      AppRoutes.login,
      AppRoutes.register,

    ];



    final isPublic =
        publicRoutes.any(
          (route) =>
              location.startsWith(route),
        );





    // -------------------------------
    // Utilisateur non connecté
    // -------------------------------

    if(!logged){


      if(isPublic){

        return null;

      }


      return AppRoutes.login;

    }





    // -------------------------------
    // Utilisateur déjà connecté
    // Redirection après login
    // -------------------------------

    if(location == AppRoutes.login ||
       location == AppRoutes.register){


      return RouteUtils.home(
        user?.role,
      );


    }






    // -------------------------------
    // Protection par rôle
    // -------------------------------


    final role =
        user?.role;



    switch(role){



      // =============================
      // CLIENT
      // =============================

      case UserRole.client:


        if(location.startsWith("/producteur") ||
           location.startsWith("/livreur")){


          return AppRoutes.catalogue;

        }


        break;






      // =============================
      // PRODUCTEUR
      // =============================

      case UserRole.producteur:


        if(location.startsWith("/livreur") ||
           location.startsWith("/panier") ||
           location.startsWith("/commandes") ||
           location.startsWith("/livraisons")){


          return AppRoutes.producteurDashboard;

        }


        break;






      // =============================
      // LIVREUR
      // =============================

      case UserRole.livreur:


        if(location.startsWith("/producteur") ||
           location.startsWith("/panier") ||
           location.startsWith("/commandes")){


          return AppRoutes.livreur;

        }


        break;






      // =============================
      // ADMIN
      // =============================

      case UserRole.admin:


        // Django admin uniquement
        // Pas de restriction Flutter


        break;




      default:

        return AppRoutes.catalogue;


    }



    return null;


  }


}