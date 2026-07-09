import 'package:flutter/foundation.dart';

import '../services/formation_service.dart';


class FormationProvider extends ChangeNotifier {

  final FormationService _service = FormationService();



  List<dynamic> _formations = [];

  Map<String, dynamic>? _formationDetail;



  bool _isLoading = false;

  String? _error;



  List<dynamic> get formations => _formations;


  Map<String, dynamic>? get formationDetail =>
      _formationDetail;


  bool get isLoading => _isLoading;


  String? get error => _error;



  // Charger formations
  Future<void> fetchFormations() async {

    try {

      _setLoading(true);


      _formations =
          await _service.fetchFormations();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Charger détail formation
  Future<void> fetchFormationDetail(
    int formationId,
  ) async {

    try {

      _setLoading(true);


      _formationDetail =
          await _service.fetchFormationDetail(
            formationId,
          );


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Créer formation
  Future<bool> createFormation(
    Map<String, dynamic> data,
  ) async {

    try {

      _setLoading(true);


      final formation =
          await _service.createFormation(
            data,
          );


      _formations.add(
        formation,
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

    _formations.clear();

    _formationDetail = null;

    _error = null;


    notifyListeners();

  }

}