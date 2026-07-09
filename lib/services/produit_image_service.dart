import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import 'api_service.dart';

class ProduitImageService {
  final ApiService _api = ApiService.instance;


  Future<List<dynamic>> fetchImages() async {
    try {
      final response = await _api.get(
        ApiConstants.produitImages,
      );

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> uploadImage({
    required int produitId,
    required MultipartFile image,
  }) async {
    try {
      final formData = FormData.fromMap({
        "produit": produitId,
        "image": image,
      });


      final response = await _api.post(
        ApiConstants.produitImages,
        data: formData,
      );


      return response.data as Map<String, dynamic>;

    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }


  Future<void> deleteImage(
    int imageId,
  ) async {
    try {
      await _api.delete(
        ApiConstants.detail(
          ApiConstants.produitImages,
          imageId,
        ),
      );

    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}