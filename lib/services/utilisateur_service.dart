import 'api_service.dart';

class UtilisateurService {

  final ApiService _api = ApiService.instance;


  // Récupérer profil
  Future<Map<String, dynamic>> getProfile() async {

    final response = await _api.get(
      "/auth/profile/",
    );

    return response.data;
  }


  // Modifier profil
  Future<Map<String, dynamic>> updateProfile(
    Map<String, dynamic> data,
  ) async {

    final response = await _api.patch(
      "/auth/profile/",
      data: data,
    );

    return response.data;
  }

}