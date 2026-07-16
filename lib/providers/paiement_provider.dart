import 'package:flutter/foundation.dart';

import '../models/paiement_model.dart';
import '../services/paiement_service.dart';


class PaiementProvider extends ChangeNotifier {


  final PaiementService _service =
      PaiementService();



  List<Paiement> _paiements = [];

  Paiement? _paiementDetail;

  Paiement? _paiementCommande;



  bool _isLoading = false;

  String? _error;



  List<Paiement> get paiements =>
      _paiements;



  Paiement? get paiementDetail =>
      _paiementDetail;



  Paiement? get paiementCommande =>
      _paiementCommande;



  bool get isLoading =>
      _isLoading;



  String? get error =>
      _error;





  // Charger tous les paiements

  Future<void> fetchPaiements() async {

    try {

      _setLoading(true);



      final data =
          await _service.fetchPaiements();



      _paiements =
          data
              .map<Paiement>(
                (json) =>
                    Paiement.fromJson(json),
              )
              .toList();



      _error = null;



    } catch(e){

      _error = e.toString();



    } finally {

      _setLoading(false);

    }

  }







  // Charger paiement d'une commande

  Future<void> fetchPaiementByCommande(

    int commandeId,

  ) async {


    try {


      _setLoading(true);



      final data =
          await _service.fetchPaiementByCommande(
            commandeId,
          );



      if(data.isNotEmpty){

        _paiementCommande =
            Paiement.fromJson(data);

      }



      _error = null;



    } catch(e){

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



      await _service.createPaiement(

        commandeId: commandeId,

        montant: montant,

        moyen: moyen,

        reference: reference,

      );



      await fetchPaiements();



      return true;



    } catch(e){


      _error = e.toString();


      return false;



    } finally {


      _setLoading(false);


    }

  }







  // Détail paiement

  Future<void> fetchPaiementDetail(

    int paiementId,

  ) async {


    try {


      _setLoading(true);



      final data =
          await _service.fetchPaiementDetail(
            paiementId,
          );



      _paiementDetail =
          Paiement.fromJson(data);



      _error = null;



    } catch(e){


      _error = e.toString();



    } finally {


      _setLoading(false);


    }


  }







  void _setLoading(bool value){

    _isLoading = value;

    notifyListeners();

  }





  void clearError(){

    _error = null;

    notifyListeners();

  }







  void clear(){

    _paiements.clear();

    _paiementDetail = null;

    _paiementCommande = null;

    _error = null;


    notifyListeners();

  }


}