import 'package:flutter/foundation.dart';

import '../models/panier_article_model.dart';
import '../services/panier_article_service.dart';

class PanierArticleProvider extends ChangeNotifier {
  final PanierArticleService _service = PanierArticleService();

  List<PanierArticle> _articles = [];

  bool _isLoading = false;

  String? _error;

  List<PanierArticle> get articles => _articles;

  bool get isLoading => _isLoading;

  String? get error => _error;

  // Total du contenu panier

  double get total {
    return _articles.fold(
      0,
      (total, article) {
        return total + article.sousTotal;
      },
    );
  }

  // Nombre de produits dans le panier

  int get nombreArticles {
    return _articles.length;
  }

  // Charger les articles

  Future<void> fetchArticles() async {
    try {
      _setLoading(true);

      _articles = await _service.fetchArticles();

      _error = null;

      notifyListeners();
    } catch (e) {
      _error = e.toString();

      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Ajouter un article

  Future<bool> ajouterArticle({
    required int produitId,
    required double quantite,
  }) async {
    try {
      final article = await _service.ajouter(
        produitId: produitId,
        quantite: quantite,
      );

      _articles.add(article);

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  // Modifier quantité

  Future<bool> modifierQuantite({
    required int articleId,
    required double quantite,
  }) async {
    try {
      final article = await _service.modifierQuantite(
        articleId: articleId,
        quantite: quantite,
      );

      final index = _articles.indexWhere(
        (item) => item.id == articleId,
      );

      if (index != -1) {
        _articles[index] = article;
      }

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  // Supprimer article

  Future<bool> supprimerArticle(
    int articleId,
  ) async {
    try {
      await _service.supprimer(
        articleId,
      );

      _articles.removeWhere(
        (article) => article.id == articleId,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  void _setLoading(
    bool value,
  ) {
    _isLoading = value;

    notifyListeners();
  }

  void clear() {
    _articles.clear();

    _error = null;

    notifyListeners();
  }
}
