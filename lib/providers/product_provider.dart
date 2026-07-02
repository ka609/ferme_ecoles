import 'package:flutter/foundation.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../services/product_service.dart';

enum LoadStatus { initial, loading, loaded, error }

/// Fournit les données du catalogue à l'écran d'accueil et au catalogue.
/// Sépare volontairement "populaires" / "nouveautés" / "catégories" pour
/// que chaque section de l'accueil ait son propre état de chargement.
class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  LoadStatus status = LoadStatus.initial;
  String? errorMessage;

  List<CategoryModel> categories = [];
  List<ProductModel> popularProducts = [];
  List<ProductModel> newProducts = [];

  int? selectedCategoryId;

  Future<void> loadHomeData() async {
    status = LoadStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _service.fetchCategories(),
        _service.fetchProducts(popular: true, limit: 8),
        _service.fetchProducts(recent: true, limit: 8),
      ]);
      categories = results[0] as List<CategoryModel>;
      popularProducts = results[1] as List<ProductModel>;
      newProducts = results[2] as List<ProductModel>;
      status = LoadStatus.loaded;
    } on ApiException catch (e) {
      status = LoadStatus.error;
      errorMessage = e.message;
    } catch (_) {
      status = LoadStatus.error;
      errorMessage = 'Impossible de charger les produits.';
    }
    notifyListeners();
  }

  Future<void> refresh() => loadHomeData();

  void selectCategory(int? categoryId) {
    selectedCategoryId = categoryId;
    notifyListeners();
    // La navigation vers le Catalogue filtré se fait depuis l'écran appelant.
  }
}