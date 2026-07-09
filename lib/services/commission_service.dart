import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class CommissionService {
  final ApiService _api = ApiService.instance;

  Future<List<dynamic>> fetchCommissions() async {
    try {
      final response = await _api.get(
        ApiConstants.commissions,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> fetchCommissionDetail(
    int commissionId,
  ) async {
    try {
      final response = await _api.get(
        ApiConstants.detail(
          ApiConstants.commissions,
          commissionId,
        ),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}