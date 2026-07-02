import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/constants/api_constants.dart';

/// Client HTTP unique de l'application. Injecte automatiquement le JWT
/// (access token) dans les requêtes et centralise la gestion des erreurs
/// réseau pour éviter de dupliquer les try/catch dans chaque service.
class ApiService {
  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          // TODO: brancher ici le refresh token automatique sur 401
          handler.next(error);
        },
      ),
    );
  }

  static final ApiService instance = ApiService._internal();

  late final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response<dynamic>> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response<dynamic>> patch(String path, {dynamic data}) {
    return _dio.patch(path, data: data);
  }

  Future<Response<dynamic>> delete(String path) {
    return _dio.delete(path);
  }
}

/// Exception métier simplifiée à afficher dans l'UI.
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  factory ApiException.fromDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ApiException('Le serveur met trop de temps à répondre. Vérifie ta connexion.');
    }
    if (e.response?.statusCode == 401) {
      return ApiException('Session expirée, merci de te reconnecter.');
    }
    if (e.response?.statusCode == 404) {
      return ApiException('Ressource introuvable.');
    }
    return ApiException('Une erreur est survenue. Réessaie plus tard.');
  }

  @override
  String toString() => message;
}