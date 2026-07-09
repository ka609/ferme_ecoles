import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class SocieteLivraisonService {
  final ApiService _api = ApiService.instance;

  Future<List<dynamic>> fetchSocietesLivraison() async {
    try {
      final response = await _api.get(
        ApiConstants.societesLivraison,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> fetchSocieteLivraisonDetail(
    int societeId,
  ) async {
    try {
      final response = await _api.get(
        ApiConstants.detail(
          ApiConstants.societesLivraison,
          societeId,
        ),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> createSocieteLivraison({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.societesLivraison,
        data: data,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> updateSocieteLivraison({
    required int societeId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _api.patch(
        ApiConstants.detail(
          ApiConstants.societesLivraison,
          societeId,
        ),
        data: data,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<void> deleteSocieteLivraison(
    int societeId,
  ) async {
    try {
      await _api.delete(
        ApiConstants.detail(
          ApiConstants.societesLivraison,
          societeId,
        ),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}