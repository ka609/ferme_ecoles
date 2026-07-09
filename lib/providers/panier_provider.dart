import 'package:flutter/foundation.dart';

import '../services/panier_service.dart';

class PanierProvider extends ChangeNotifier {
  final PanierService _service = PanierService();

  List<dynamic> _paniers = [];
  List<dynamic> _articles = [];

  bool _isLoading = false;
  String? _error;

  List<dynamic> get paniers => _paniers;

  List<dynamic> get articles => _articles;

  bool get isLoading => _isLoading;

  String? get error => _error;

  // Total panier
  double get total {
    return _articles.fold(
      0,
      (somme, article) {
        final prix =
            double.tryParse(
                  article["prix"].toString(),
                ) ??
                0;

        final quantite =
            int.tryParse(
                  article["quantite"].toString(),
                ) ??
                0;

        return somme + (prix * quantite);
      },
    );
  }

  // Charger panier
  Future<void> fetchPanier() async {
    try {
      _setLoading(true);

      _paniers = await _service.fetchPanier();

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Charger articles panier
  Future<void> fetchArticlesPanier() async {
    try {
      _setLoading(true);

      _articles = await _service.fetchArticlesPanier();

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Ajouter article
  Future<bool> ajouterAuPanier({
    required int produitId,
    required int quantite,
  }) async {
    try {
      final article = await _service.ajouterAuPanier(
        produitId: produitId,
        quantite: quantite,
      );

      _articles.add(article);

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      return false;
    }
  }

  // Modifier quantité
  Future<bool> updateQuantiteArticle({
    required int articleId,
    required int quantite,
  }) async {
    try {
      final article = await _service.updateQuantiteArticle(
        articleId: articleId,
        quantite: quantite,
      );

      final index = _articles.indexWhere(
        (item) => item["id"] == articleId,
      );

      if (index != -1) {
        _articles[index] = article;
      }

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      return false;
    }
  }

  // Supprimer article
  Future<bool> supprimerArticle(int articleId) async {
    try {
      await _service.supprimerArticle(articleId);

      _articles.removeWhere(
        (item) => item["id"] == articleId,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      return false;
    }
  }

  // Mise à jour chargement
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
    _paniers.clear();

    _articles.clear();

    _error = null;

    notifyListeners();
  }
}