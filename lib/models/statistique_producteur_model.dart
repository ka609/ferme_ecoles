class StatistiqueProducteur {
  final int nombreProduits;
  final int produitsValides;
  final int produitsDisponibles;
  final double stockTotal;
  final int nombreCommandes;

  StatistiqueProducteur({
    required this.nombreProduits,
    required this.produitsValides,
    required this.produitsDisponibles,
    required this.stockTotal,
    required this.nombreCommandes,
  });


  factory StatistiqueProducteur.fromJson(
    Map<String, dynamic> json,
  ) {
    return StatistiqueProducteur(
      nombreProduits:
          json["nombre_produits"] ?? 0,

      produitsValides:
          json["produits_valides"] ?? 0,

      produitsDisponibles:
          json["produits_disponibles"] ?? 0,

      stockTotal:
          double.tryParse(
                json["stock_total"].toString(),
              ) ??
              0,

      nombreCommandes:
          json["nombre_commandes"] ?? 0,
    );
  }
}