import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'token_manager.dart';


class ApiService {

  ApiService._internal() {

    _dio = Dio(

      BaseOptions(

        baseUrl: ApiConstants.baseUrl,

        connectTimeout: const Duration(seconds: 15),

        receiveTimeout: const Duration(seconds: 15),

        headers: {
          'Content-Type': 'application/json'
        },

      ),

    );


    _dio.interceptors.add(

      InterceptorsWrapper(

        onRequest: (
          options,
          handler
        ) async {

          final token = await TokenManager.getAccessToken();


          if (token != null) {

            options.headers['Authorization'] =
                'Bearer $token';

          }


          handler.next(options);

        },


        onError: (
          error,
          handler
        ) {

          handler.next(error);

        },

      ),

    );

  }


  static final ApiService instance =
      ApiService._internal();


  late final Dio _dio;



  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {

    return _dio.get(
      path,
      queryParameters: queryParameters,
    );

  }



  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
  }) {

    return _dio.post(
      path,
      data: data,
    );

  }



  Future<Response<dynamic>> patch(
    String path, {
    dynamic data,
  }) {

    return _dio.patch(
      path,
      data: data,
    );

  }



  Future<Response<dynamic>> delete(
    String path
  ) {

    return _dio.delete(
      path,
    );

  }

}



class ApiException implements Exception {

  final String message;


  ApiException(this.message);



  factory ApiException.fromDioError(
    DioException e
  ) {

    if (
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout
    ) {

      return ApiException(
        'Le serveur met trop de temps à répondre.',
      );

    }



    if (e.response?.statusCode == 401) {

      return ApiException(
        'Session expirée, merci de te reconnecter.',
      );

    }



    if (e.response?.statusCode == 404) {

      return ApiException(
        'Ressource introuvable.',
      );

    }



    return ApiException(
      'Une erreur est survenue. Réessaie plus tard.',
    );

  }



  @override
  String toString() => message;

}