import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';


class CommandeService {

  final ApiService _api = ApiService.instance;



  Future<List<dynamic>> fetchCommandes({

    String? statut,

  }) async {

    try {

      final response = await _api.get(

        ApiConstants.commandes,

        queryParameters: {

          if(statut != null)

            'statut': statut,

        },

      );



      if(response.data is List){

        return response.data as List<dynamic>;

      }



      if(response.data is Map<String, dynamic>){

        return response.data["results"] ?? [];

      }



      return [];



    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }

  }







  Future<Map<String, dynamic>> fetchCommandeDetail(

    int commandeId,

  ) async {

    try {

      final response = await _api.get(

        ApiConstants.detail(

          ApiConstants.commandes,

          commandeId,

        ),

      );


      return Map<String,dynamic>.from(

        response.data,

      );


    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }

  }







  Future<Map<String, dynamic>> createCommandeFromPanier({

    required int producteurId,

    required String adresseLivraison,

    required List<Map<String, dynamic>> lignes,

  }) async {


    try {


      final response = await _api.post(

        ApiConstants.commandes,

        data: {

          'producteur': producteurId,

          'adresse_livraison': adresseLivraison,

          'lignes': lignes,

        },

      );



      return Map<String,dynamic>.from(

        response.data,

      );



    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }

  }









  Future<Map<String, dynamic>> updateCommandeStatut(

    int commandeId,

    String statut,

  ) async {


    try {


      final response = await _api.patch(

        ApiConstants.detail(

          ApiConstants.commandes,

          commandeId,

        ),

        data: {

          'statut': statut,

        },

      );



      return Map<String,dynamic>.from(

        response.data,

      );



    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }

  }







  Future<Map<String, dynamic>> annulerCommande(

    int commandeId,

  ) async {


    return updateCommandeStatut(

      commandeId,

      'ANNULEE',

    );

  }







  Future<Map<String, dynamic>> fetchPaiement(

    int commandeId,

  ) async {


    try {


      final response = await _api.get(

        ApiConstants.paiements,

        queryParameters: {

          'commande': commandeId,

        },

      );



      List<dynamic> data;



      if(response.data is List){

        data = response.data;

      }

      else if(response.data is Map<String,dynamic>){

        data = response.data["results"] ?? [];

      }

      else{

        data = [];

      }





      return data.isNotEmpty

          ? Map<String,dynamic>.from(data.first)

          : {};



    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }

  }







  Future<Map<String, dynamic>> createPaiement({

    required int commandeId,

    required double montant,

    required String moyen,

    String? reference,

  }) async {


    try {


      final response = await _api.post(

        ApiConstants.paiements,

        data: {

          'commande': commandeId,

          'montant': montant,

          'moyen': moyen,

          if(reference != null)

            'reference': reference,

        },

      );



      return Map<String,dynamic>.from(

        response.data,

      );



    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }

  }


}