import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class VersementService {
  final ApiService _api = ApiService.instance;

  Future<List<dynamic>> fetchVersements() async {
    try {
      final response = await _api.get(
        ApiConstants.versements,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> fetchVersementDetail(
    int versementId,
  ) async {
    try {
      final response = await _api.get(
        ApiConstants.detail(
          ApiConstants.versements,
          versementId,
        ),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}