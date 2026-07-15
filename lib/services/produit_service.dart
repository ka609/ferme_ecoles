import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';


class ProduitService {


  final ApiService _api =
      ApiService.instance;



  Future<List<dynamic>> fetchCatalogue() async {

    try {

      final response =
          await _api.get(
            ApiConstants.catalogue,
          );


      return response.data as List<dynamic>;


    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }

  }






  Future<Map<String, dynamic>> fetchProduitDetail(
    int produitId,
  ) async {

    try {


      final response =
          await _api.get(

        ApiConstants.detail(
          ApiConstants.produits,
          produitId,
        ),

      );


      return response.data as Map<String, dynamic>;



    } on DioException catch (e) {

      throw ApiException.fromDioError(e);

    }

  }







  Future<List<dynamic>> fetchMesProduits() async {

    try {


      final response =
          await _api.get(

            ApiConstants.mesProduits,

          );



      return response.data as List<dynamic>;



    } on DioException catch (e) {


      throw ApiException.fromDioError(e);


    }

  }









  Future<Map<String, dynamic>> createProduit({

    required String nom,

    required String description,

    required double prix,

    required double stock,

    required String unite,

    required String typeProduit,

    required int categorieId,

    String? image,

  }) async {


    try {



      final response =
          await _api.post(


        ApiConstants.produits,


        data: {


          "nom":
              nom,


          "description":
              description,


          "prix":
              prix,


          "stock":
              stock,


          "unite":
              unite,


          "type_produit":
              typeProduit,


          "categorie":
              categorieId,



          if (image != null)
            "image":
                image,



        },

      );
    print(response.data);



      return response.data as Map<String, dynamic>;




    } on DioException catch (e) {


      throw ApiException.fromDioError(e);


    }

  }









  Future<Map<String, dynamic>> updateProduit({

    required int produitId,

    required Map<String, dynamic> data,


  }) async {


    try {



      final response =
          await _api.patch(


        ApiConstants.detail(

          ApiConstants.produits,

          produitId,

        ),


        data:
            data,


      );



      return response.data as Map<String, dynamic>;



    } on DioException catch (e) {


      throw ApiException.fromDioError(e);


    }

  }









  Future<void> deleteProduit(

    int produitId,

  ) async {


    try {



      await _api.delete(


        ApiConstants.detail(

          ApiConstants.produits,

          produitId,

        ),


      );




    } on DioException catch (e) {


      throw ApiException.fromDioError(e);


    }


  }



}