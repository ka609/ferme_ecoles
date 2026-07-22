import 'package:flutter/foundation.dart';

import '../models/livraison_model.dart';
import '../services/livraison_service.dart';

class LivraisonProvider extends ChangeNotifier {
  final LivraisonService _service = LivraisonService();

  List<Livraison> _livraisons = [];

  List<Livraison> _livraisonsDisponibles = [];

  Livraison? _livraisonDetail;

  bool _isLoading = false;

  String? _error;

  List<Livraison> get livraisons => _livraisons;

  List<Livraison> get livraisonsDisponibles => _livraisonsDisponibles;

  Livraison? get livraisonDetail => _livraisonDetail;

  bool get isLoading => _isLoading;

  String? get error => _error;

  // Charger toutes les livraisons
  Future<void> fetchLivraisons() async {
    try {
      _setLoading(true);

      _livraisons = await _service.fetchLivraisons();

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Charger les livraisons disponibles
  Future<void> fetchLivraisonsDisponibles() async {
    try {
      _setLoading(true);

      _livraisonsDisponibles = await _service.fetchLivraisonsDisponibles();

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Charger une livraison
  Future<void> fetchLivraisonDetail(
    int livraisonId,
  ) async {
    try {
      _setLoading(true);

      _livraisonDetail = await _service.fetchLivraisonDetail(
        livraisonId,
      );

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Prendre une livraison
  Future<Livraison?> prendreLivraison(
    int livraisonId,
  ) async {
    try {
      _setLoading(true);

      final livraison = await _service.prendreLivraison(
        livraisonId,
      );

      _updateLivraison(livraison);

      return livraison;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Relâcher une livraison
  Future<bool> relacherLivraison(
    int livraisonId,
  ) async {
    try {
      _setLoading(true);

      final livraison = await _service.relacherLivraison(
        livraisonId,
      );

      _updateLivraison(livraison);

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Marquer comme livrée
  Future<bool> marquerLivraisonEffectuee(
    int livraisonId,
  ) async {
    try {
      _setLoading(true);

      final livraison = await _service.marquerLivraisonEffectuee(
        livraisonId,
      );

      _updateLivraison(livraison);

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

// Confirmer la réception
  Future<bool> confirmerReception(
    int livraisonId,
  ) async {
    try {
      _setLoading(true);

      final livraison = await _service.confirmerReception(
        livraisonId,
      );

      _updateLivraison(
        livraison,
      );

      return true;
    } catch (e) {
      _error = e.toString();

      debugPrint(
        "Erreur confirmation réception : $e",
      );

      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Mettre à jour une livraison
  void _updateLivraison(
    Livraison livraison,
  ) {
    final index = _livraisons.indexWhere(
      (item) => item.id == livraison.id,
    );

    if (index != -1) {
      _livraisons[index] = livraison;
    }

    final disponibleIndex = _livraisonsDisponibles.indexWhere(
      (item) => item.id == livraison.id,
    );

    if (disponibleIndex != -1) {
      _livraisonsDisponibles[disponibleIndex] = livraison;
    }

    _livraisonDetail = livraison;

    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clear() {
    _livraisons.clear();
    _livraisonsDisponibles.clear();
    _livraisonDetail = null;
    _error = null;

    notifyListeners();
  }
}
