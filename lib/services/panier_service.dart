import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class PanierService {
  final ApiService _api = ApiService.instance;

  Future<List<dynamic>> fetchPanier() async {
    try {
      final response = await _api.get(
        ApiConstants.paniers,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> ajouterAuPanier({
    required int produitId,
    required int quantite,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.ajouterPanier,
        data: {
          'produit': produitId,
          'quantite': quantite,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<List<dynamic>> fetchArticlesPanier() async {
    try {
      final response = await _api.get(
        ApiConstants.panierArticles,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> updateQuantiteArticle({
    required int articleId,
    required int quantite,
  }) async {
    try {
      final response = await _api.patch(
        ApiConstants.detail(
          ApiConstants.panierArticles,
          articleId,
        ),
        data: {
          'quantite': quantite,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<void> supprimerArticle(
    int articleId,
  ) async {
    try {
      await _api.delete(
        ApiConstants.detail(
          ApiConstants.panierArticles,
          articleId,
        ),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}