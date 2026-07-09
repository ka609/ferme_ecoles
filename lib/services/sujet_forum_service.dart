import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class SujetForumService {
  final ApiService _api = ApiService.instance;


  Future<List<dynamic>> fetchSujets() async {
    try {
      final response = await _api.get(
        ApiConstants.sujetsForum,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> createSujet({
    required String titre,
    required String contenu,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.sujetsForum,
        data: {
          "titre": titre,
          "contenu": contenu,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}