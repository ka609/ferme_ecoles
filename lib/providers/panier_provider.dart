import 'package:flutter/foundation.dart';

import '../models/panier_model.dart';
import '../services/panier_service.dart';


class PanierProvider extends ChangeNotifier {


  final PanierService _service =
      PanierService();



  List<Panier> _paniers = [];

  Panier? _detail;


  bool _isLoading = false;

  String? _error;





  List<Panier> get paniers =>
      _paniers;



  Panier? get detail =>
      _detail;



  bool get isLoading =>
      _isLoading;



  String? get error =>
      _error;







  // Charger les paniers du client

  Future<void> fetchPaniers() async {

    try {

      _setLoading(true);


      _paniers =
          await _service.fetchPaniers();



      _error = null;


      notifyListeners();


    } catch(e) {


      _error = e.toString();


      notifyListeners();


    } finally {


      _setLoading(false);


    }

  }








  // Charger détail panier

  Future<void> fetchPanierDetail(
    int panierId,
  ) async {


    try {


      _setLoading(true);



      _detail =
          await _service.fetchPanierDetail(
            panierId,
          );



      _error = null;


      notifyListeners();



    } catch(e) {


      _error = e.toString();


      notifyListeners();


    } finally {


      _setLoading(false);


    }

  }









  // Supprimer panier

  Future<bool> deletePanier(
    int panierId,
  ) async {


    try {


      await _service.deletePanier(
        panierId,
      );



      _paniers.removeWhere(
        (panier) =>
            panier.id == panierId,
      );



      notifyListeners();



      return true;



    } catch(e) {



      _error = e.toString();


      notifyListeners();


      return false;


    }


  }










  void _setLoading(
    bool value,
  ){

    _isLoading = value;

    notifyListeners();

  }








  void clear(){

    _paniers.clear();

    _detail = null;

    _error = null;


    notifyListeners();

  }



}