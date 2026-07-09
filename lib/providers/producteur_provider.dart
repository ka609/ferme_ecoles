import 'package:flutter/foundation.dart';

import '../services/producteur_service.dart';


class ProducteurProvider extends ChangeNotifier {

  final ProducteurService _service =
      ProducteurService();



  List<dynamic> _producteurs = [];

  Map<String, dynamic>? _producteurDetail;


  bool _isLoading = false;

  String? _error;



  List<dynamic> get producteurs =>
      _producteurs;


  Map<String, dynamic>? get producteurDetail =>
      _producteurDetail;


  bool get isLoading =>
      _isLoading;


  String? get error =>
      _error;



  // Charger producteurs
  Future<void> fetchProducteurs() async {

    try {

      _setLoading(true);


      _producteurs =
          await _service.fetchProducteurs();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Charger détail producteur
  Future<void> fetchProducteur(
    int id,
  ) async {

    try {

      _setLoading(true);


      _producteurDetail =
          await _service.fetchProducteur(
            id,
          );


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Créer producteur
  Future<bool> createProducteur(
    Map<String,dynamic> data,
  ) async {

    try {

      final producteur =
          await _service.createProducteur(
            data,
          );


      _producteurs.add(
        producteur,
      );


      notifyListeners();


      return true;


    } catch (e) {

      _error = e.toString();

      return false;

    }

  }



  // Modifier producteur
  Future<bool> updateProducteur(
    int id,
    Map<String,dynamic> data,
  ) async {

    try {

      final producteur =
          await _service.updateProducteur(
            id,
            data,
          );


      final index =
          _producteurs.indexWhere(
            (item) => item["id"] == id,
          );


      if(index != -1){

        _producteurs[index] = producteur;

      }


      _producteurDetail = producteur;


      notifyListeners();


      return true;


    } catch(e){

      _error = e.toString();

      return false;

    }

  }



  // Mise à jour chargement
  void _setLoading(
    bool value,
  ){

    _isLoading = value;

    notifyListeners();

  }



  // Nettoyer erreur
  void clearError(){

    _error = null;

    notifyListeners();

  }



  // Réinitialiser données
  void clear(){

    _producteurs.clear();

    _producteurDetail = null;

    _error = null;


    notifyListeners();

  }

}