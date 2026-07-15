import 'package:flutter/foundation.dart';

import '../models/commande_model.dart';
import '../services/commande_service.dart';


class CommandeProvider extends ChangeNotifier {

  final CommandeService _service = CommandeService();


  List<Commande> _commandes = [];

  Commande? _commandeDetail;

  Map<String, dynamic>? _paiement;


  bool _isLoading = false;

  String? _error;



  List<Commande> get commandes => _commandes;


  Commande? get commandeDetail =>
      _commandeDetail;


  Map<String, dynamic>? get paiement =>
      _paiement;


  bool get isLoading => _isLoading;


  String? get error => _error;



  // Charger commandes
  Future<void> fetchCommandes({

    String? statut,

  }) async {

    try {

      _setLoading(true);


      final data =
          await _service.fetchCommandes(
            statut: statut,
          );


      _commandes = data
          .map<Commande>(
            (json) => Commande.fromJson(json),
          )
          .toList();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }




  // Charger détail commande
  Future<void> fetchCommandeDetail(

    int commandeId,

  ) async {
    print("===== FETCH COMMANDE DETAIL =====");


    try {

      _setLoading(true);
      print("Avant appel service");


      final data =
          await _service.fetchCommandeDetail(
            commandeId,
          );

      print("Après appel service");
      print(data);


      _commandeDetail =
          Commande.fromJson(data);


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }





  // Créer commande
  Future<bool> createCommandeFromPanier({

    required int producteurId,

    required String adresseLivraison,

    required List<Map<String, dynamic>> lignes,

  }) async {

    try {

      _setLoading(true);


      final data =
          await _service.createCommandeFromPanier(

            producteurId: producteurId,

            adresseLivraison: adresseLivraison,

            lignes: lignes,

          );


      final commande =
          Commande.fromJson(data);



      _commandes.add(
        commande,
      );


      _error = null;


      notifyListeners();


      return true;


    } catch (e) {

      _error = e.toString();


      return false;


    } finally {

      _setLoading(false);

    }

  }





  // Modifier statut commande
  Future<bool> updateCommandeStatut({

    required int commandeId,

    required String statut,

  }) async {

    try {

      _setLoading(true);


      final data =
          await _service.updateCommandeStatut(

            commandeId,

            statut,

          );


      final commande =
          Commande.fromJson(data);



      _updateCommandeList(
        commande,
      );


      _commandeDetail = commande;


      _error = null;


      notifyListeners();


      return true;


    } catch (e) {

      _error = e.toString();


      return false;


    } finally {

      _setLoading(false);

    }

  }





  // Annuler commande
  Future<bool> annulerCommande(

    int commandeId,

  ) async {


    try {

      _setLoading(true);



      final data =
          await _service.annulerCommande(
            commandeId,
          );


      final commande =
          Commande.fromJson(data);



      _updateCommandeList(
        commande,
      );


      _commandeDetail = commande;


      notifyListeners();


      return true;



    } catch (e) {

      _error = e.toString();


      return false;


    } finally {

      _setLoading(false);

    }

  }





  // Charger paiement
  Future<void> fetchPaiement(

    int commandeId,

  ) async {


    try {

      _setLoading(true);



      _paiement =
          await _service.fetchPaiement(
            commandeId,
          );


      _error = null;



    } catch (e) {

      _error = e.toString();



    } finally {

      _setLoading(false);

    }

  }





  // Créer paiement
  Future<bool> createPaiement({

    required int commandeId,

    required double montant,

    required String moyen,

    String? reference,


  }) async {


    try {


      _setLoading(true);



      _paiement =
          await _service.createPaiement(

            commandeId: commandeId,

            montant: montant,

            moyen: moyen,

            reference: reference,

          );



      notifyListeners();



      return true;



    } catch (e) {


      _error = e.toString();


      return false;



    } finally {


      _setLoading(false);


    }

  }





  // Mise à jour liste
  void _updateCommandeList(

    Commande commande,

  ) {


    final index =
        _commandes.indexWhere(

          (item) =>
              item.id == commande.id,

        );



    if(index != -1){

      _commandes[index] = commande;

    }


  }





  // Gestion chargement
  void _setLoading(

    bool value,

  ) {

    _isLoading = value;

    notifyListeners();

  }





  // Nettoyer erreur
  void clearError(){

    _error = null;

    notifyListeners();

  }





  // Réinitialiser données
  void clear(){

    _commandes = [];

    _commandeDetail = null;

    _paiement = null;

    _error = null;


    notifyListeners();

  }

}