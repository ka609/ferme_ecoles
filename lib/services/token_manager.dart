import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class TokenManager {

  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();


  // Sauvegarde tokens
  static Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {

    await _storage.write(
      key: 'access_token',
      value: access,
    );


    await _storage.write(
      key: 'refresh_token',
      value: refresh,
    );

  }



  // Récupère access token
  static Future<String?> getAccessToken() async {

    return await _storage.read(
      key: 'access_token',
    );

  }



  // Récupère refresh token
  static Future<String?> getRefreshToken() async {

    return await _storage.read(
      key: 'refresh_token',
    );

  }



  // Supprime tokens
  static Future<void> clearTokens() async {

    await _storage.delete(
      key: 'access_token',
    );


    await _storage.delete(
      key: 'refresh_token',
    );

  }



  // Vérifie connexion
  static Future<bool> hasToken() async {

    final token = await getAccessToken();

    return token != null;

  }

}