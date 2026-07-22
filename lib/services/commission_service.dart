import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';


class CommissionService {

  final ApiService _api =
      ApiService.instance;



  // Charger toutes les commissions
  Future<List<Map<String, dynamic>>> fetchCommissions() async {

    try {

      final response =
          await _api.get(
            ApiConstants.commissions,
          );


      return List<Map<String, dynamic>>.from(
        response.data,
      );


    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }

  }





  // Charger détail commission
  Future<Map<String, dynamic>> fetchCommissionDetail(
    int commissionId,
  ) async {

    try {

      final response =
          await _api.get(
            ApiConstants.detail(
              ApiConstants.commissions,
              commissionId,
            ),
          );



      return Map<String, dynamic>.from(
        response.data,
      );


    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }

  }

}