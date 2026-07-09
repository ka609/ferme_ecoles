import 'package:flutter/foundation.dart';

import '../services/societe_livraison_service.dart';


class SocieteLivraisonProvider extends ChangeNotifier {

  final SocieteLivraisonService _service =
      SocieteLivraisonService();


  List<dynamic> _societes = [];

  Map<String,dynamic>? _detail;


  bool _isLoading = false;

  String? _error;



  List<dynamic> get societes => _societes;

  Map<String,dynamic>? get detail => _detail;

  bool get isLoading => _isLoading;

  String? get error => _error;



  // Charger sociétés
  Future<void> fetchSocietes() async {

    try {

      _setLoading(true);

      _societes =
          await _service.fetchSocietesLivraison();

      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }
  }



  // Charger détail société
  Future<void> fetchDetail(
    int id,
  ) async {

    try {

      _setLoading(true);

      _detail =
          await _service.fetchSocieteLivraisonDetail(
            id,
          );


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }
  }



  // Créer société
  Future<void> createSociete(
    Map<String,dynamic> data,
  ) async {

    try {

      await _service.createSocieteLivraison(
        data: data,
      );

      await fetchSocietes();


    } catch(e){

      _error = e.toString();

    }
  }



  // Modifier société
  Future<void> updateSociete(
    int id,
    Map<String,dynamic> data,
  ) async {

    try {

      await _service.updateSocieteLivraison(
        societeId: id,
        data: data,
      );

      await fetchSocietes();


    } catch(e){

      _error = e.toString();

    }
  }



  // Supprimer société
  Future<void> deleteSociete(
    int id,
  ) async {

    try {

      await _service.deleteSocieteLivraison(
        id,
      );

      await fetchSocietes();


    } catch(e){

      _error = e.toString();

    }
  }



  void _setLoading(bool value){

    _isLoading=value;

    notifyListeners();

  }

}