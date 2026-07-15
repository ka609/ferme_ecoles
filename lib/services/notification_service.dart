import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';



class NotificationService {


  final ApiService _api = ApiService.instance;





  // Liste notifications utilisateur
  Future<List<dynamic>> fetchNotifications() async {


    try {


      final response = await _api.get(

        ApiConstants.notifications,

      );



      if(response.data is List){

        return response.data as List<dynamic>;

      }



      if(response.data is Map<String,dynamic>){

        return response.data["results"] ?? [];

      }



      return [];



    } on DioException catch(e){


      throw ApiException.fromDioError(e);


    }


  }








  // Marquer notification lue
  Future<Map<String,dynamic>> readNotification(

    int id,

  ) async {


    try {


      final response = await _api.patch(

        ApiConstants.notificationRead(id),

      );



      return Map<String,dynamic>.from(

        response.data,

      );



    } on DioException catch(e){


      throw ApiException.fromDioError(e);


    }


  }


}