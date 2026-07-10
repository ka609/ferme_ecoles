import 'package:flutter/foundation.dart';

import '../models/produit_model.dart';
import '../services/produit_service.dart';


class ProduitProvider extends ChangeNotifier {

  final ProduitService _service = ProduitService();



  List<Produit> _catalogue = [];

  List<Produit> _mesProduits = [];


  Produit? _produitDetail;


  bool _isLoading = false;

  String? _error;



  List<Produit> get catalogue => _catalogue;


  List<Produit> get mesProduits => _mesProduits;


  Produit? get produitDetail => _produitDetail;


  bool get isLoading => _isLoading;


  String? get error => _error;



  // Charger catalogue
  Future<void> fetchCatalogue() async {

    try {

      _setLoading(true);


      _catalogue =
          await _service.fetchCatalogue()
              .then(
                (data) => data
                    .map(
                      (e) => Produit.fromJson(e),
                    )
                    .toList(),
              );


      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Charger mes produits
  Future<void> fetchMesProduits() async {

    try {

      _setLoading(true);


      _mesProduits =
          await _service.fetchMesProduits()
              .then(
                (data) => data
                    .map(
                      (e) => Produit.fromJson(e),
                    )
                    .toList(),
              );


      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Charger détail produit
  Future<void> fetchProduitDetail(
    int produitId,
  ) async {

    try {

      _setLoading(true);


      final data =
          await _service.fetchProduitDetail(
            produitId,
          );


      _produitDetail =
          Produit.fromJson(data);


      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Créer produit
  Future<bool> createProduit({
    required String nom,
    required String description,
    required double prix,
    required int categorieId,
    String? image,
  }) async {

    try {

      final data =
          await _service.createProduit(
            nom: nom,
            description: description,
            prix: prix,
            categorieId: categorieId,
            image: image,
          );


      _mesProduits.add(
        Produit.fromJson(data),
      );


      notifyListeners();


      return true;


    } catch(e){

      _error = e.toString();

      return false;

    }

  }



  // Modifier produit
  Future<bool> updateProduit(
    int produitId,
    Map<String,dynamic> data,
  ) async {

    try {

      final response =
          await _service.updateProduit(
            produitId: produitId,
            data: data,
          );


      final produit =
          Produit.fromJson(response);


      final index =
          _mesProduits.indexWhere(
            (item) => item.id == produitId,
          );


      if(index != -1){

        _mesProduits[index] = produit;

      }


      _produitDetail = produit;


      notifyListeners();


      return true;


    } catch(e){

      _error = e.toString();

      return false;

    }

  }



  // Supprimer produit
  Future<bool> deleteProduit(
    int produitId,
  ) async {

    try {

      await _service.deleteProduit(
        produitId,
      );


      _mesProduits.removeWhere(
        (item) => item.id == produitId,
      );


      notifyListeners();


      return true;


    } catch(e){

      _error = e.toString();

      return false;

    }

  }



  // Mise à jour chargement
  void _setLoading(bool value){

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

    _catalogue.clear();

    _mesProduits.clear();

    _produitDetail = null;

    _error = null;


    notifyListeners();

  }

}