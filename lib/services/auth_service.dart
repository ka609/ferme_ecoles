import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _api = ApiService.instance;

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _api.post(
        ApiConstants.login,
        data: {'username': username, 'password': password},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ApiException('Identifiants incorrects.');
      }
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> fetchMe() async {
    try {
      final response = await _api.get(ApiConstants.profile);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    try {
      await _api.post(ApiConstants.register, data: data);
    } on DioException catch (e) {
      throw ApiException(_extractRegisterError(e));
    }
  }

  String _extractRegisterError(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      if (data['detail'] != null) return data['detail'].toString();

      final premierChamp = data.entries.firstOrNull;
      if (premierChamp != null) {
        final valeur = premierChamp.value;
        final message = valeur is List
            ? valeur.first.toString()
            : valeur.toString();
        return '${premierChamp.key} : $message';
      }
    }
    return 'Erreur lors de l\'inscription.';
  }
}

extension _FirstOrNullExtension<K, V> on Iterable<MapEntry<K, V>> {
  MapEntry<K, V>? get firstOrNull => isEmpty ? null : first;
}