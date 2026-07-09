import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';


class JournalActiviteService {

  final ApiService _api = ApiService.instance;


  // Liste journal activité
  Future<List<dynamic>> fetchJournal() async {

    try {

      final response = await _api.get(
        ApiConstants.journalActivites,
      );

      return response.data as List<dynamic>;

    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }
  }
}