import 'package:flutter/foundation.dart';

import '../services/paiement_service.dart';


class PaiementProvider extends ChangeNotifier {

  final PaiementService _service =
      PaiementService();



  List<dynamic> _paiements = [];

  Map<String, dynamic>? _paiementDetail;

  Map<String, dynamic>? _paiementCommande;


  bool _isLoading = false;

  String? _error;



  List<dynamic> get paiements => _paiements;

  Map<String, dynamic>? get paiementDetail =>
      _paiementDetail;

  Map<String, dynamic>? get paiementCommande =>
      _paiementCommande;


  bool get isLoading => _isLoading;

  String? get error => _error;



  // Charger paiements
  Future<void> fetchPaiements() async {

    try {

      _setLoading(true);


      _paiements =
          await _service.fetchPaiements();


      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }
  }



  // Charger paiement commande
  Future<void> fetchPaiementByCommande(
    int commandeId,
  ) async {

    try {

      _setLoading(true);


      _paiementCommande =
          await _service.fetchPaiementByCommande(
            commandeId,
          );


      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }
  }



  // Créer paiement
  // Créer paiement
Future<bool> createPaiement({
  required int commandeId,
  required double montant,
  required String moyen,
  String? reference,
}) async {
  try {
    _setLoading(true);

    await _service.createPaiement(
      commandeId: commandeId,
      montant: montant,
      moyen: moyen,
      reference: reference,
    );

    await fetchPaiements();

    return true;

  } catch (e) {
    _error = e.toString();

    return false;

  } finally {
    _setLoading(false);
  }
}


  // Charger détail paiement
  Future<void> fetchPaiementDetail(
    int paiementId,
  ) async {

    try {

      _setLoading(true);


      _paiementDetail =
          await _service.fetchPaiementDetail(
            paiementId,
          );


      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }
  }



  // Mise à jour chargement
  void _setLoading(
    bool value,
  ){

    _isLoading = value;

    notifyListeners();

  }



  // Nettoyer erreur
  void clearError(){

    _error = null;

    notifyListeners();

  }



  // Réinitialiser
  void clear(){

    _paiements.clear();

    _paiementDetail = null;

    _paiementCommande = null;

    _error = null;


    notifyListeners();

  }

}