import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import 'api_service.dart';

class ProductService {
  final ApiService _api = ApiService.instance;

  /// Récupère la liste des produits. [popular] et [recent] permettent de
  /// filtrer côté API (query params) pour les sections "Produits populaires"
  /// et "Nouveautés" de l'écran d'accueil.
  Future<List<ProductModel>> fetchProducts({
    int? categoryId,
    String? search,
    bool? popular,
    bool? recent,
    int? limit,
  }) async {
    try {
      final response = await _api.get(
        ApiConstants.products,
        queryParameters: {
          if (categoryId != null) 'category': categoryId,
          if (search != null && search.isNotEmpty) 'search': search,
          if (popular == true) 'is_popular': true,
          if (recent == true) 'ordering': '-published_at',
          if (limit != null) 'limit': limit,
        },
      );
      final data = response.data;
      final List results = data is Map ? (data['results'] ?? []) : data;
      return results
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _api.get(ApiConstants.categories);
      final data = response.data;
      final List results = data is Map ? (data['results'] ?? []) : data;
      return results
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<ProductModel> fetchProductDetail(int id) async {
    try {
      final response = await _api.get(ApiConstants.productDetail(id));
      return ProductModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}