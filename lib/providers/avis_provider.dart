import 'package:flutter/material.dart';

import '../services/avis_service.dart';


class AvisProvider extends ChangeNotifier {

  final AvisService _service = AvisService();


  List<dynamic> _avis = [];

  bool _isLoading = false;

  String? _error;



  List<dynamic> get avis => _avis;

  bool get isLoading => _isLoading;

  String? get error => _error;



  // Charger les avis produit
  Future<void> fetchAvis({
    int? produitId,
  }) async {

    _setLoading(true);


    try {

      _avis = await _service.fetchAvis(
        produitId: produitId,
      );


      _error = null;

      notifyListeners();


    } catch (e) {

      _error = e.toString();

      notifyListeners();


    } finally {

      _setLoading(false);

    }

  }



  // Charger détail avis
  Future<Map<String, dynamic>?> fetchAvisDetail(
    int avisId,
  ) async {

    try {

      return await _service.fetchAvisDetail(
        avisId,
      );


    } catch (e) {

      _error = e.toString();

      notifyListeners();

      return null;

    }

  }



  // Ajouter un avis
  Future<bool> createAvis({
    required int produitId,
    required int note,
    required String commentaire,
  }) async {

    try {

      await _service.createAvis(
        produitId: produitId,
        note: note,
        commentaire: commentaire,
      );


      await fetchAvis(
        produitId: produitId,
      );


      return true;


    } catch (e) {

      _error = e.toString();

      notifyListeners();

      return false;

    }

  }



  // Modifier un avis
  Future<bool> updateAvis(
    int avisId,
    Map<String, dynamic> data,
  ) async {

    try {

      await _service.updateAvis(
        avisId,
        data,
      );


      await fetchAvis();


      return true;


    } catch (e) {

      _error = e.toString();

      notifyListeners();

      return false;

    }

  }



  // Supprimer un avis
  Future<bool> deleteAvis(
    int avisId,
  ) async {

    try {

      await _service.deleteAvis(
        avisId,
      );


      _avis.removeWhere(
        (item) => item["id"] == avisId,
      );


      notifyListeners();


      return true;


    } catch (e) {

      _error = e.toString();

      notifyListeners();

      return false;

    }

  }



  // Modifier chargement
  void _setLoading(
    bool value,
  ){

    _isLoading = value;

    notifyListeners();

  }

}