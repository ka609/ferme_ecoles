import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class AvisService {
  final ApiService _api = ApiService.instance;

  Future<List<dynamic>> fetchAvis({int? produitId}) async {
    try {
      final response = await _api.get(
        ApiConstants.avis,
        queryParameters: {
          if (produitId != null) 'produit': produitId,
        },
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> fetchAvisDetail(
    int avisId,
  ) async {
    try {
      final response = await _api.get(
        ApiConstants.detail(
          ApiConstants.avis,
          avisId,
        ),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> createAvis({
    required int produitId,
    required int note,
    required String commentaire,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.avis,
        data: {
          "produit": produitId,
          "note": note,
          "commentaire": commentaire,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> updateAvis(
    int avisId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _api.patch(
        ApiConstants.detail(
          ApiConstants.avis,
          avisId,
        ),
        data: data,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<void> deleteAvis(
    int avisId,
  ) async {
    try {
      await _api.delete(
        ApiConstants.detail(
          ApiConstants.avis,
          avisId,
        ),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}