import 'package:flutter/foundation.dart';

import '../services/parametre_service.dart';


class ParametreProvider extends ChangeNotifier {

  final ParametreService _service =
      ParametreService();



  List<dynamic> _parametres = [];


  bool _isLoading = false;

  String? _error;



  List<dynamic> get parametres =>
      _parametres;


  bool get isLoading =>
      _isLoading;


  String? get error =>
      _error;



  // Charger paramètres
  Future<void> fetchParametres() async {

    try {

      _setLoading(true);


      _parametres =
          await _service.fetchParametres();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Créer paramètre
  Future<bool> createParametre(
    Map<String,dynamic> data,
  ) async {

    try {

      final parametre =
          await _service.createParametre(
            data,
          );


      _parametres.add(
        parametre,
      );


      notifyListeners();


      return true;


    } catch (e) {

      _error = e.toString();

      return false;

    }

  }



  // Modifier paramètre
  Future<bool> updateParametre(
    int id,
    Map<String,dynamic> data,
  ) async {

    try {

      final parametre =
          await _service.updateParametre(
            id,
            data,
          );


      final index =
          _parametres.indexWhere(
            (item) =>
                item["id"] == id,
          );


      if (index != -1) {

        _parametres[index] = parametre;

      }


      notifyListeners();


      return true;


    } catch (e) {

      _error = e.toString();

      return false;

    }

  }



  // Mise à jour chargement
  void _setLoading(
    bool value,
  ) {

    _isLoading = value;

    notifyListeners();

  }



  // Nettoyer erreur
  void clearError() {

    _error = null;

    notifyListeners();

  }



  // Réinitialiser données
  void clear() {

    _parametres.clear();

    _error = null;


    notifyListeners();

  }

}