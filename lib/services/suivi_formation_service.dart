import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class SuiviFormationService {
  final ApiService _api = ApiService.instance;


  Future<List<dynamic>> fetchSuivis() async {
    try {
      final response = await _api.get(
        ApiConstants.suivisFormations,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> updateProgression({
    required int suiviId,
    required int progression,
  }) async {
    try {
      final response = await _api.patch(
        ApiConstants.detail(
          ApiConstants.suivisFormations,
          suiviId,
        ),
        data: {
          "progression": progression,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}