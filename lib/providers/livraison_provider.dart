import 'package:flutter/foundation.dart';

import '../services/livraison_service.dart';


class LivraisonProvider extends ChangeNotifier {

  final LivraisonService _service =
      LivraisonService();



  List<dynamic> _livraisons = [];

  List<dynamic> _livraisonsDisponibles = [];


  Map<String, dynamic>? _livraisonDetail;


  bool _isLoading = false;

  String? _error;



  List<dynamic> get livraisons =>
      _livraisons;


  List<dynamic> get livraisonsDisponibles =>
      _livraisonsDisponibles;


  Map<String, dynamic>? get livraisonDetail =>
      _livraisonDetail;


  bool get isLoading =>
      _isLoading;


  String? get error =>
      _error;



  // Charger livraisons
  Future<void> fetchLivraisons() async {

    try {

      _setLoading(true);


      _livraisons =
          await _service.fetchLivraisons();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Charger livraisons disponibles
  Future<void> fetchLivraisonsDisponibles() async {

    try {

      _setLoading(true);


      _livraisonsDisponibles =
          await _service.fetchLivraisonsDisponibles();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Charger détail livraison
  Future<void> fetchLivraisonDetail(
    int livraisonId,
  ) async {

    try {

      _setLoading(true);


      _livraisonDetail =
          await _service.fetchLivraisonDetail(
            livraisonId,
          );


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Prendre livraison
  Future<bool> prendreLivraison(
    int livraisonId,
  ) async {

    try {

      _setLoading(true);


      final livraison =
          await _service.prendreLivraison(
            livraisonId,
          );


      _updateLivraison(
        livraison,
      );


      return true;


    } catch (e) {

      _error = e.toString();

      return false;


    } finally {

      _setLoading(false);

    }

  }



  // Relâcher livraison
  Future<bool> relacherLivraison(
    int livraisonId,
  ) async {

    try {

      _setLoading(true);


      final livraison =
          await _service.relacherLivraison(
            livraisonId,
          );


      _updateLivraison(
        livraison,
      );


      return true;


    } catch (e) {

      _error = e.toString();

      return false;


    } finally {

      _setLoading(false);

    }

  }



  // Marquer livrée
  Future<bool> marquerLivraisonEffectuee(
    int livraisonId,
  ) async {

    try {

      _setLoading(true);


      final livraison =
          await _service.marquerLivraisonEffectuee(
            livraisonId,
          );


      _updateLivraison(
        livraison,
      );


      return true;


    } catch (e) {

      _error = e.toString();

      return false;


    } finally {

      _setLoading(false);

    }

  }



  // Confirmer réception
  Future<bool> confirmerReception(
    int livraisonId,
  ) async {

    try {

      _setLoading(true);


      final livraison =
          await _service.confirmerReception(
            livraisonId,
          );


      _updateLivraison(
        livraison,
      );


      return true;


    } catch (e) {

      _error = e.toString();

      return false;


    } finally {

      _setLoading(false);

    }

  }



  // Mettre à jour livraison
  void _updateLivraison(
    Map<String, dynamic> livraison,
  ) {

    final index =
        _livraisons.indexWhere(
          (item) =>
              item["id"] == livraison["id"],
        );


    if (index != -1) {

      _livraisons[index] = livraison;

    }


    _livraisonDetail = livraison;


    notifyListeners();

  }



  // Mise à jour chargement
  void _setLoading(
    bool value,
  ) {

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

    _livraisons.clear();

    _livraisonsDisponibles.clear();

    _livraisonDetail = null;

    _error = null;


    notifyListeners();

  }

}