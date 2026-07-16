import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import '../models/panier_article_model.dart';
import 'api_service.dart';


class PanierArticleService {

  final ApiService _api = ApiService.instance;



  // Liste des articles du panier
  Future<List<PanierArticle>> fetchArticles() async {

    try {

      final response = await _api.get(
        ApiConstants.panierArticles,
      );


      return (response.data as List)

          .map(
            (json) => PanierArticle.fromJson(json),
          )

          .toList();


    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }

  }





  // Ajouter un produit au panier
  Future<PanierArticle> ajouter({

    required int produitId,

    required double quantite,

  }) async {


    try {

      final response = await _api.post(

        ApiConstants.panierArticles,

        data: {

          "produit": produitId,

          "quantite": quantite,

        },

      );
   print("REPONSE PANIER ARTICLE : ${response.data}");



      return PanierArticle.fromJson(
        response.data,
      );


    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }

  }







  // Modifier quantité
  Future<PanierArticle> modifierQuantite({

    required int articleId,

    required double quantite,

  }) async {


    try {


      final response = await _api.patch(

        ApiConstants.detail(
          ApiConstants.panierArticles,
          articleId,
        ),


        data: {

          "quantite": quantite,

        },

      );



      return PanierArticle.fromJson(
        response.data,
      );



    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }

  }







  // Supprimer un article
  Future<void> supprimer(
    int articleId,
  ) async {


    try {


      await _api.delete(

        ApiConstants.detail(
          ApiConstants.panierArticles,
          articleId,
        ),

      );



    } on DioException catch(e){

      throw ApiException.fromDioError(e);

    }

  }

}