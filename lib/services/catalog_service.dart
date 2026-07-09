import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';


class CatalogService {

  final ApiService _api = ApiService.instance;


  // Récupère les catégories publiques
  Future<List<dynamic>> fetchCategories() async {

    try {

      final response = await _api.get(
        ApiConstants.categories,
      );

      return response.data as List<dynamic>;

    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }
  }



  // Récupère les produits visibles
  Future<List<dynamic>> fetchProduits({

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


      return response.data as List<dynamic>;


    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }

  }



  // Récupère détail produit public
  Future<Map<String,dynamic>> fetchProduitDetail(

    int produitId

  ) async {

    try {

      final response = await _api.get(

        ApiConstants.detail(
          ApiConstants.produits,
          produitId,
        ),

      );


      return response.data as Map<String,dynamic>;


    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }

  }

}