class ProduitImage {
  // Image model
  final int id;

  final String image;


  ProduitImage({
    required this.id,
    required this.image,
  });


  factory ProduitImage.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProduitImage(
      id: json["id"],
      image: json["image"] ?? "",
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
    };
  }
}