import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';


class PaiementService {


  final ApiService _api =
      ApiService.instance;





  Future<List<dynamic>> fetchPaiements() async {

    try {


      final response =
          await _api.get(
            ApiConstants.paiements,
          );



      return response.data is List
          ? response.data as List<dynamic>
          : [];



    } on DioException catch(e) {


      throw ApiException.fromDioError(e);


    }

  }







  Future<Map<String,dynamic>> fetchPaiementByCommande(

    int commandeId,

  ) async {


    try {


      final response =
          await _api.get(

            ApiConstants.paiements,

            queryParameters: {

              "commande": commandeId,

            },

          );




      if(response.data is List){

        final data =
            response.data as List;


        return data.isNotEmpty
            ? data.first as Map<String,dynamic>
            : {};

      }



      return response.data
          as Map<String,dynamic>;



    } on DioException catch(e){


      throw ApiException.fromDioError(e);


    }

  }








  Future<Map<String,dynamic>> createPaiement({

    required int commandeId,

    required double montant,

    required String moyen,

    String? reference,

  }) async {


    try {


      final response =
          await _api.post(

            ApiConstants.paiements,

            data: {


              "commande": commandeId,


              "montant": montant,


              "moyen": moyen,


              if(reference != null)

                "reference": reference,


            },

          );



      return response.data
          as Map<String,dynamic>;



    } on DioException catch(e){


      throw ApiException.fromDioError(e);


    }

  }







  Future<Map<String,dynamic>> fetchPaiementDetail(

    int paiementId,

  ) async {


    try {


      final response =
          await _api.get(

            ApiConstants.detail(

              ApiConstants.paiements,

              paiementId,

            ),

          );



      return response.data
          as Map<String,dynamic>;



    } on DioException catch(e){


      throw ApiException.fromDioError(e);


    }

  }



}