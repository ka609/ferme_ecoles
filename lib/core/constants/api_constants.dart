class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "http://127.0.0.1:8000/api";

  static const String register = "/auth/register/";
  static const String login = "/auth/login/";
  static const String profile = "/auth/me/";

  static const String utilisateurs = "/utilisateurs/";
  static const String producteurs = "/producteurs/";
  static const String notifications = "/notifications/";
  static const String journalActivites = "/journal-activites/";
  static const String parametres = "/parametres/";

  static const String categories = "/categories/";
  static const String produits = "/produits/";
  static const String certifications = "/certifications/";
  static const String produitImages = "/produit-images/";
  static const String catalogue = "/produits/catalogue/";
  static const String mesProduits = "/produits/mes_produits/";

  static const String paniers = "/paniers/";
  static const String panierArticles = "/panier-articles/";
  static const String ajouterPanier = "/paniers/ajouter/";

  static const String commandes = "/commandes/";

  static const String paiements = "/paiements/";

  static const String versements = "/versements/";

  static const String livraisons = "/livraisons/";

  static const String commissions = "/commissions/";

  static const String societesLivraison = "/societes-livraison/";

  static const String avis = "/avis/";

  static const String sujetsForum = "/sujets-forum/";

  static const String reponsesForum = "/reponses-forum/";

  static const String formations = "/formations/";

  static const String suivisFormations = "/suivis-formations/";

  static const String mediaUrl = "http://127.0.0.1:8000";

  static String detail(
    String endpoint,
    int id,
  ) {
    return "$endpoint$id/";
  }

  static const String statistiqueProducteur =
    "/producteur/statistiques/";

  static const String livraisonsDisponibles =
    "/livraisons/disponibles/";

  static String prendreLivraison(
    int id,
  ) {
    return "${livraisons}$id/prendre/";
  }

  static String relacherLivraison(
    int id,
  ) {
    return "${livraisons}$id/relacher/";
  }

  static String livrerLivraison(
    int id,
  ) {
    return "${livraisons}$id/livrer/";
  }
static String notificationRead(int id){
  return "${notifications}$id/read/";
} 

  static String confirmerReception(
    int id,
  ) {
    return "${livraisons}$id/confirmer_reception/";
  }
}
