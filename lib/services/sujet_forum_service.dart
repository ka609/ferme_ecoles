import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';



class SujetForumService {


  final ApiService _api = ApiService.instance;





  Future<List<dynamic>> fetchSujets() async {


    try {


      final response = await _api.get(

        ApiConstants.sujetsForum,

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








  Future<Map<String, dynamic>> createSujet({

    required String titre,

    required String contenu,

  }) async {


    try {


      final response = await _api.post(

        ApiConstants.sujetsForum,

        data: {

          "titre": titre,

          "contenu": contenu,

        },

      );



      return Map<String, dynamic>.from(

        response.data,

      );



    } on DioException catch(e){


      throw ApiException.fromDioError(e);


    }


  }


}