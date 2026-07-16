import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import '../models/panier_model.dart';
import 'api_service.dart';


class PanierService {


  final ApiService _api =
      ApiService.instance;





  // Liste des paniers

  Future<List<Panier>> fetchPaniers() async {


    try {


      final response =
          await _api.get(
            ApiConstants.paniers,
          );



      return (response.data as List)

          .map(
            (json) =>
                Panier.fromJson(json),
          )

          .toList();



    } on DioException catch(e) {


      throw ApiException.fromDioError(e);

    }


  }







  // Détail panier

  Future<Panier> fetchPanierDetail(
    int panierId,
  ) async {


    try {


      final response =
          await _api.get(

            ApiConstants.detail(
              ApiConstants.paniers,
              panierId,
            ),

          );



      return Panier.fromJson(
        response.data,
      );



    } on DioException catch(e) {


      throw ApiException.fromDioError(e);

    }

  }








  // Supprimer panier

  Future<void> deletePanier(
    int panierId,
  ) async {


    try {


      await _api.delete(

        ApiConstants.detail(
          ApiConstants.paniers,
          panierId,
        ),

      );



    } on DioException catch(e) {


      throw ApiException.fromDioError(e);

    }

  }


}