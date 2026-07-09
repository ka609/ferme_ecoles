import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class LivraisonService {
  final ApiService _api = ApiService.instance;

  Future<List<dynamic>> fetchLivraisons() async {
    try {
      final response = await _api.get(
        ApiConstants.livraisons,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> fetchLivraisonDetail(
    int livraisonId,
  ) async {
    try {
      final response = await _api.get(
        ApiConstants.detail(
          ApiConstants.livraisons,
          livraisonId,
        ),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<List<dynamic>> fetchLivraisonsDisponibles() async {
    try {
      final response = await _api.get(
        ApiConstants.livraisonsDisponibles,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> prendreLivraison(
    int livraisonId,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.prendreLivraison(livraisonId),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> relacherLivraison(
    int livraisonId,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.relacherLivraison(livraisonId),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> marquerLivraisonEffectuee(
    int livraisonId,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.livrerLivraison(livraisonId),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> confirmerReception(
    int livraisonId,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.confirmerReception(livraisonId),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}