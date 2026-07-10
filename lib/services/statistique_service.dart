import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class StatistiqueService {

  final ApiService _api =
      ApiService.instance;


  Future<Map<String, dynamic>>
      fetchStatistiqueProducteur() async {

    try {

      final response =
          await _api.get(
            ApiConstants.statistiqueProducteur,
          );

      return response.data
          as Map<String, dynamic>;

    } on DioException catch (e) {

      throw ApiException.fromDioError(e);
    }
  }
}