import '../../models/user_enum.dart';

import 'app_routes.dart';


class RouteUtils {


  static String home(UserRole? role) {


    switch(role) {


      case UserRole.producteur:

        return AppRoutes.producteurDashboard;


      case UserRole.livreur:

        return AppRoutes.livreur;


      case UserRole.client:

        return AppRoutes.catalogue;


      case UserRole.admin:

        return AppRoutes.catalogue;


      default:

        return AppRoutes.catalogue;

    }

  }


}