import 'package:flutter/foundation.dart';

import '../services/catalog_service.dart';


class CatalogProvider extends ChangeNotifier {

  final CatalogService _service = CatalogService();


  List<dynamic> _categories = [];

  List<dynamic> _produits = [];

  Map<String, dynamic>? _produitDetail;


  bool _isLoading = false;

  String? _error;



  List<dynamic> get categories => _categories;

  List<dynamic> get produits => _produits;

  Map<String, dynamic>? get produitDetail => _produitDetail;


  bool get isLoading => _isLoading;

  String? get error => _error;



  // Charge catégories
  Future<void> fetchCategories() async {

    try {

      _setLoading(true);


      _categories = await _service.fetchCategories();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Charge catalogue public
  Future<void> fetchProduits({

    int? categorieId,

    String? typeProduit,

    String? search,

  }) async {

    try {

      _setLoading(true);


      _produits = await _service.fetchProduits(

        categorieId: categorieId,

        typeProduit: typeProduit,

        search: search,

      );


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Charge détail produit
  Future<void> fetchProduitDetail(

    int produitId

  ) async {

    try {

      _setLoading(true);


      _produitDetail = await _service.fetchProduitDetail(

        produitId,

      );


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Gestion chargement
  void _setLoading(bool value) {

    _isLoading = value;

    notifyListeners();

  }



  // Nettoie erreur
  void clearError() {

    _error = null;

    notifyListeners();

  }



  // Réinitialise données
  void clear() {

    _categories = [];

    _produits = [];

    _produitDetail = null;

    _error = null;


    notifyListeners();

  }

}