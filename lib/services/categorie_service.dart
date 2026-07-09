import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class CategorieService {
  final ApiService _api = ApiService.instance;

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

  Future<Map<String, dynamic>> fetchCategorieDetail(
    int categorieId,
  ) async {
    try {
      final response = await _api.get(
        ApiConstants.detail(
          ApiConstants.categories,
          categorieId,
        ),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> createCategorie({
    required String nom,
    String? description,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.categories,
        data: {
          'nom': nom,
          if (description != null)
            'description': description,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> updateCategorie({
    required int categorieId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _api.patch(
        ApiConstants.detail(
          ApiConstants.categories,
          categorieId,
        ),
        data: data,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<void> deleteCategorie(
    int categorieId,
  ) async {
    try {
      await _api.delete(
        ApiConstants.detail(
          ApiConstants.categories,
          categorieId,
        ),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}