import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class ReponseForumService {
  final ApiService _api = ApiService.instance;


  Future<List<dynamic>> fetchReponses(
    int sujetId,
  ) async {
    try {
      final response = await _api.get(
        ApiConstants.reponsesForum,
        queryParameters: {
          "sujet": sujetId,
        },
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> createReponse({
    required int sujetId,
    required String contenu,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.reponsesForum,
        data: {
          "sujet": sujetId,
          "contenu": contenu,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}