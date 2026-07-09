import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';


class ProducteurService {

  final ApiService _api = ApiService.instance;


  // Liste les producteurs
  Future<List<dynamic>> fetchProducteurs() async {

    try {

      final response = await _api.get(
        ApiConstants.producteurs,
      );

      return response.data as List<dynamic>;

    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }
  }


  // Détail producteur
  Future<Map<String,dynamic>> fetchProducteur(
    int id,
  ) async {

    try {

      final response = await _api.get(
        ApiConstants.detail(
          ApiConstants.producteurs,
          id,
        ),
      );

      return response.data as Map<String,dynamic>;

    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }
  }


  // Création producteur admin
  Future<Map<String,dynamic>> createProducteur(
    Map<String,dynamic> data,
  ) async {

    try {

      final response = await _api.post(
        ApiConstants.producteurs,
        data:data,
      );

      return response.data as Map<String,dynamic>;

    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }
  }


  // Modification producteur
  Future<Map<String,dynamic>> updateProducteur(
    int id,
    Map<String,dynamic> data,
  ) async {

    try {

      final response = await _api.patch(
        ApiConstants.detail(
          ApiConstants.producteurs,
          id,
        ),
        data:data,
      );

      return response.data as Map<String,dynamic>;

    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }
  }
}