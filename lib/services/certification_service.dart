import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class CertificationService {
  final ApiService _api = ApiService.instance;


  Future<List<dynamic>> fetchCertifications() async {
    try {
      final response = await _api.get(
        ApiConstants.certifications,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> createCertification(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.certifications,
        data: data,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> updateCertification(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _api.patch(
        ApiConstants.detail(
          ApiConstants.certifications,
          id,
        ),
        data: data,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}