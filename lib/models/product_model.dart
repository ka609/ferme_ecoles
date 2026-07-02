import 'category_model.dart';

/// Représente un produit agroécologique publié par un producteur.
/// Correspond à l'endpoint Django `/api/products/`.
class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String unit; // kg, litre, pièce, botte...
  final int stock;
  final String? imageUrl;
  final CategoryModel? category;
  final String producerName;
  final String? producerContact;
  final DateTime? publishedAt;
  final bool isNew;
  final bool isPopular;
  final double? averageRating;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.unit,
    required this.stock,
    this.imageUrl,
    this.category,
    required this.producerName,
    this.producerContact,
    this.publishedAt,
    this.isNew = false,
    this.isPopular = false,
    this.averageRating,
  });

  bool get inStock => stock > 0;

  String get formattedPrice => '${price.toStringAsFixed(0)} FCFA / $unit';

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: (json['name'] ?? json['nom'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      price: double.tryParse(json['price']?.toString() ?? json['prix']?.toString() ?? '0') ?? 0,
      unit: (json['unit'] ?? json['unite'] ?? 'unité') as String,
      stock: (json['stock'] ?? json['stock_disponible'] ?? 0) is int
          ? (json['stock'] ?? json['stock_disponible'] ?? 0) as int
          : int.tryParse('${json['stock'] ?? json['stock_disponible'] ?? 0}') ?? 0,
      imageUrl: json['image'] as String? ?? json['photo'] as String?,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      producerName: (json['producer_name'] ??
              json['nom_producteur'] ??
              json['producer']?['name'] ??
              'Producteur') as String,
      producerContact: json['producer_contact'] as String? ??
          json['contact_producteur'] as String? ??
          json['producer']?['phone'] as String?,
      publishedAt: json['published_at'] != null
          ? DateTime.tryParse(json['published_at'].toString())
          : (json['date_publication'] != null
              ? DateTime.tryParse(json['date_publication'].toString())
              : null),
      isNew: json['is_new'] as bool? ?? false,
      isPopular: json['is_popular'] as bool? ?? false,
      averageRating: json['average_rating'] != null
          ? double.tryParse(json['average_rating'].toString())
          : null,
    );
  }
}