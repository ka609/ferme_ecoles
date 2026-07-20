import 'package:flutter/foundation.dart';

import '../models/categorie_model.dart';
import '../services/categorie_service.dart';


class CategorieProvider extends ChangeNotifier {

  final CategorieService _service = CategorieService();



  List<Categorie> _categories = [];

  Categorie? _categorieDetail;



  bool _isLoading = false;

  String? _error;



  // Catégorie sélectionnée dans le catalogue

  int? _categorieSelectionneeId;



  List<Categorie> get categories => _categories;


  Categorie? get categorieDetail => _categorieDetail;


  bool get isLoading => _isLoading;


  String? get error => _error;



  int? get categorieSelectionneeId =>
      _categorieSelectionneeId;




  // Retourne l'objet catégorie sélectionné

  Categorie? get categorieSelectionnee {

    if (_categorieSelectionneeId == null) {

      return null;

    }


    try {

      return _categories.firstWhere(

        (categorie) =>

        categorie.id == _categorieSelectionneeId,

      );

    } catch (e) {

      return null;

    }

  }





  // Charger catégories

  Future<void> fetchCategories() async {

    try {

      _setLoading(true);


      final data = await _service.fetchCategories();


      _categories = (data as List)

          .map((e) => Categorie.fromJson(e))

          .toList();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }





  // Sélection dropdown catégorie

  void selectionnerCategorie(int? id) {


    _categorieSelectionneeId = id;


    notifyListeners();

  }





  // Réinitialiser filtre catégorie

  void resetCategorie() {


    _categorieSelectionneeId = null;


    notifyListeners();

  }





  // Charger détail catégorie

  Future<void> fetchCategorieDetail(int categorieId) async {

    try {

      _setLoading(true);


      final data = await _service.fetchCategorieDetail(categorieId);


      _categorieDetail = Categorie.fromJson(data);


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }





  // Créer catégorie

  Future<bool> createCategorie({

    required String nom,

    String? description,

  }) async {


    try {


      _setLoading(true);



      await _service.createCategorie(

        nom: nom,

        description: description,

      );



      await fetchCategories();



      return true;



    } catch (e) {


      _error = e.toString();


      return false;



    } finally {


      _setLoading(false);


    }

  }





  // Modifier catégorie

  Future<bool> updateCategorie({

    required int categorieId,

    required Map<String, dynamic> data,

  }) async {


    try {


      _setLoading(true);



      await _service.updateCategorie(

        categorieId: categorieId,

        data: data,

      );



      await fetchCategories();



      return true;



    } catch (e) {


      _error = e.toString();


      return false;



    } finally {


      _setLoading(false);


    }

  }





  // Supprimer catégorie

  Future<bool> deleteCategorie(int categorieId) async {


    try {


      _setLoading(true);



      await _service.deleteCategorie(categorieId);



      await fetchCategories();



      return true;



    } catch (e) {


      _error = e.toString();


      return false;



    } finally {


      _setLoading(false);


    }

  }





  // Gestion chargement

  void _setLoading(bool value) {


    _isLoading = value;


    notifyListeners();


  }





  // Nettoyer erreur

  void clearError() {


    _error = null;


    notifyListeners();


  }





  // Réinitialiser données

  void clear() {


    _categories = [];


    _categorieDetail = null;


    _categorieSelectionneeId = null;


    _error = null;



    notifyListeners();


  }

}