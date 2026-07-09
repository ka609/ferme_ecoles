import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';


class ParametreService {

  final ApiService _api = ApiService.instance;


  // Liste paramètres
  Future<List<dynamic>> fetchParametres() async {

    try {

      final response = await _api.get(
        ApiConstants.parametres,
      );

      return response.data as List<dynamic>;

    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }
  }


  // Création paramètre
  Future<Map<String,dynamic>> createParametre(
    Map<String,dynamic> data,
  ) async {

    try {

      final response = await _api.post(
        ApiConstants.parametres,
        data:data,
      );

      return response.data as Map<String,dynamic>;

    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }
  }


  // Modification paramètre
  Future<Map<String,dynamic>> updateParametre(
    int id,
    Map<String,dynamic> data,
  ) async {

    try {

      final response = await _api.patch(
        ApiConstants.detail(
          ApiConstants.parametres,
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