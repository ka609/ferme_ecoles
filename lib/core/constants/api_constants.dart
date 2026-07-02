/// Centralise les URLs de l'API Django REST Framework.
/// Adapte [baseUrl] selon l'environnement (émulateur Android, web, prod...).
class ApiConstants {
  ApiConstants._();

  // Emulateur Android : 10.0.2.2 pointe vers le localhost de la machine hôte.
  // Sur le web / iOS simulator, utilise plutôt 127.0.0.1 ou l'URL de prod.
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // Auth
  static const String login = '$baseUrl/auth/login/';
  static const String refreshToken = '$baseUrl/auth/refresh/';
  static const String register = '$baseUrl/auth/register/';

  // Catalogue
  static const String products = '$baseUrl/products/';
  static const String categories = '$baseUrl/categories/';

  // Panier
  static const String carts = '$baseUrl/carts/';
  static const String cartItems = '$baseUrl/cart-items/';

  // Commandes
  static const String orders = '$baseUrl/orders/';
  static const String payments = '$baseUrl/payments/';
  static const String deliveries = '$baseUrl/deliveries/';

  // Notifications
  static const String notifications = '$baseUrl/notifications/';

  // Producteur
  static const String productions = '$baseUrl/productions/';

  // Utilisateur
  static const String users = '$baseUrl/users/';

  static String productDetail(int id) => '$products$id/';
  static String categoryProducts(int categoryId) => '$products?category=$categoryId';
}