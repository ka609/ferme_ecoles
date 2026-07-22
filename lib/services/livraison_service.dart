import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import '../models/livraison_model.dart';
import 'api_service.dart';

class LivraisonService {
  final ApiService _api = ApiService.instance;

  // Liste des livraisons
  Future<List<Livraison>> fetchLivraisons() async {
    try {
      final response = await _api.get(
        ApiConstants.livraisons,
      );

      return (response.data as List)
          .map(
            (json) => Livraison.fromJson(json),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // Détail d'une livraison
  Future<Livraison> fetchLivraisonDetail(
    int livraisonId,
  ) async {
    try {
      final response = await _api.get(
        ApiConstants.detail(
          ApiConstants.livraisons,
          livraisonId,
        ),
      );

      return Livraison.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // Livraisons disponibles
  Future<List<Livraison>> fetchLivraisonsDisponibles() async {
    try {
      final response = await _api.get(
        ApiConstants.livraisonsDisponibles,
      );

      return (response.data as List)
          .map(
            (json) => Livraison.fromJson(json),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // Prendre une livraison
  Future<Livraison> prendreLivraison(
    int livraisonId,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.prendreLivraison(
          livraisonId,
        ),
      );

      return Livraison.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // Relâcher une livraison
  Future<Livraison> relacherLivraison(
    int livraisonId,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.relacherLivraison(
          livraisonId,
        ),
      );

      return Livraison.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // Marquer une livraison comme effectuée
  Future<Livraison> marquerLivraisonEffectuee(
    int livraisonId,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.livrerLivraison(
          livraisonId,
        ),
      );

      return Livraison.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // Confirmer la réception
  Future<Livraison> confirmerReception(
    int livraisonId,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.confirmerReception(
          livraisonId,
        ),
      );

      return Livraison.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}