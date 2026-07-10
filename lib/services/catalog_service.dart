import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import '../models/categorie_model.dart';
import '../models/produit_model.dart';
import 'api_service.dart';


class CatalogService {

  final ApiService _api = ApiService.instance;


  // Récupère les catégories publiques
  Future<List<Categorie>> fetchCategories() async {

    try {

      final response = await _api.get(
        ApiConstants.categories,
      );


      return (response.data as List)
          .map(
            (json) => Categorie.fromJson(json),
          )
          .toList();


    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }

  }



  // Récupère les produits visibles
  Future<List<Produit>> fetchProduits({

    int? categorieId,

    String? typeProduit,

    String? search,

  }) async {

    try {

      final response = await _api.get(

        ApiConstants.produits,

        queryParameters: {

          if (categorieId != null)
            "categorie": categorieId,

          if (typeProduit != null)
            "type_produit": typeProduit,

          if (search != null && search.isNotEmpty)
            "search": search,

        },

      );


      return (response.data as List)
          .map(
            (json) => Produit.fromJson(json),
          )
          .toList();


    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }

  }



  // Récupère détail produit public
  Future<Produit> fetchProduitDetail(

    int produitId

  ) async {

    try {

      final response = await _api.get(

        ApiConstants.detail(
          ApiConstants.produits,
          produitId,
        ),

      );


      return Produit.fromJson(
        response.data,
      );


    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }

  }

}