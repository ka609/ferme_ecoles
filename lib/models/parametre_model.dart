class Parametre {
  // Parametre model
  final int id;

  final double commissionPlateforme;

  final double commissionLivreur;

  final String devise;

  final bool maintenance;


  Parametre({
    required this.id,
    required this.commissionPlateforme,
    required this.commissionLivreur,
    required this.devise,
    required this.maintenance,
  });


  factory Parametre.fromJson(
    Map<String, dynamic> json,
  ) {
    return Parametre(
      id: json["id"],

      commissionPlateforme:
          double.tryParse(
            json["commission_plateforme"]
                .toString(),
          ) ??
          0,

      commissionLivreur:
          double.tryParse(
            json["commission_livreur"]
                .toString(),
          ) ??
          0,

      devise: json["devise"] ?? "",

      maintenance:
          json["maintenance"] ?? false,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,

      "commission_plateforme":
          commissionPlateforme,

      "commission_livreur":
          commissionLivreur,

      "devise": devise,

      "maintenance": maintenance,
    };
  }
}