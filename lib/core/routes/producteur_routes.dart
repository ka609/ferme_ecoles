import 'package:go_router/go_router.dart';


import '../../models/produit_model.dart';


import '../../screens/producteur/producteur_dashboard_screen.dart';
import '../../screens/producteur/mes_produits_screen.dart';
import '../../screens/producteur/add_produit_screen.dart';
import '../../screens/producteur/edit_produit_screen.dart';
import '../../screens/producteur/certification_screen.dart';
import '../../screens/producteur/statistiques_screen.dart';
import '../../screens/producteur/producteur_commandes_screen.dart';
import '../../screens/producteur/formations_screen.dart';



import 'app_routes.dart';



final List<RouteBase> producteurRoutes = [



  // --------------------------------------------------
  // Tableau de bord producteur
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.producteurDashboard,


    builder: (
      context,
      state,
    ){

      return const ProducteurDashboard();

    },

  ),





  // --------------------------------------------------
  // Liste des produits du producteur
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.producteurProduits,


    builder: (
      context,
      state,
    ){

      return const MesProduitsScreen();

    },

  ),





  // --------------------------------------------------
  // Ajouter un produit
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.producteurAjouterProduit,


    builder: (
      context,
      state,
    ){

      return const AddProduitScreen();

    },

  ),





  // --------------------------------------------------
  // Modifier un produit
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.producteurModifierProduit,


    builder: (
      context,
      state,
    ){


      final produit =
          state.extra as Produit;



      return EditProduitScreen(

        produit: produit,

      );


    },

  ),






  // --------------------------------------------------
  // Certification BIO SPG
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.certification,


    builder: (
      context,
      state,
    ){

      return const CertificationScreen();

    },

  ),






  // --------------------------------------------------
  // Statistiques producteur
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.statistiques,


    builder: (
      context,
      state,
    ){

      return const StatistiquesScreen();

    },

  ),

  GoRoute(
  path: AppRoutes.formationsProducteur,

  builder: (context, state) =>
      const FormationsProducteurScreen(),
),





  // --------------------------------------------------
  // Commandes reçues par le producteur
  // --------------------------------------------------

  GoRoute(

    path: AppRoutes.producteurCommandes,


    builder: (
      context,
      state,
    ){

      return const ProducteurCommandesScreen();

    },

  ),


];