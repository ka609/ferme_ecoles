class CategoryModel {
  final int id;
  final String name;
  final String? iconUrl;

  CategoryModel({
    required this.id,
    required this.name,
    this.iconUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: (json['name'] ?? json['nom'] ?? '') as String,
      iconUrl: json['icon'] as String? ?? json['icone'] as String?,
    );
  }
}