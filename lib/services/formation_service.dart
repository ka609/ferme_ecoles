import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class FormationService {
  final ApiService _api = ApiService.instance;


  Future<List<dynamic>> fetchFormations() async {
    try {
      final response = await _api.get(
        ApiConstants.formations,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> fetchFormationDetail(
    int formationId,
  ) async {
    try {
      final response = await _api.get(
        ApiConstants.detail(
          ApiConstants.formations,
          formationId,
        ),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> createFormation(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.formations,
        data: data,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}