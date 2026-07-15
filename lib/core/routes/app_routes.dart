class AppRoutes {


  // Auth

  static const login = "/login";

  static const register = "/register";



  // Public

  static const catalogue = "/catalogue";

  static const produit = "/produit";



  // Client

  static const panier = "/panier";

  static const commandes = "/commandes";

  static const commandeDetail =
    "/commandes/detail";

  static const livraisons = "/livraisons";

  static const clientProfil = "/client/profil";



  // Producteur

  static const producteurDashboard =
      "/producteur/dashboard";


  static const producteurProduits =
      "/producteur/produits";


  static const producteurAjouterProduit =
      "/producteur/produits/ajouter";


  static const producteurModifierProduit =
      "/producteur/produits/:id/modifier";


  static const producteurCommandes =
      "/producteur/commandes";


  static const certification =
      "/producteur/certification";


  static const statistiques =
      "/producteur/statistiques";

  static const formationsProducteur =
    "/producteur/formations";


  // Livreur

  static const livreur =
      "/livreur";


  static const livraisonsDisponibles =
      "/livreur/livraisons-disponibles";


  static const mesLivraisons =
      "/livreur/mes-livraisons";


  static const livreurProfil =
      "/livreur/profil";


  static const livraisonDetail =
      "/livreur/livraison/:id";



  // Shared

  static const profile =
      "/profile";


  static const notifications =
      "/notifications";



  // Forum

static const forum =
    "/forum";


static const nouveauSujet =
    "/forum/nouveau";


static const sujetDetail =
    "/forum/detail";


static const reponsesForum =
    "/forum/reponses";

  //paiement
  static const paiement = "/paiement";

}