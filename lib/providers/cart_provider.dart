import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get subtotal => product.price * quantity;
}

/// Panier client. La logique complète (sync avec /api/carts/ et
/// /api/cart-items/) sera branchée lors de l'écran Panier ; pour l'instant
/// ce provider expose juste ce dont l'écran d'accueil a besoin : le nombre
/// d'articles pour le badge du panier dans l'AppBar.
class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  int get itemCount => _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount => _items.values.fold(0, (sum, item) => sum + item.subtotal);

  void addProduct(ProductModel product, {int quantity = 1}) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += quantity;
    } else {
      _items[product.id] = CartItem(product: product, quantity: quantity);
    }
    notifyListeners();
  }

  void removeProduct(int productId) {
    _items.remove(productId);
    notifyListeners();
  }
}