import 'package:flutter/foundation.dart';

import '../services/suivi_formation_service.dart';


class SuiviFormationProvider extends ChangeNotifier {

  final SuiviFormationService _service =
      SuiviFormationService();


  List<dynamic> _suivis = [];

  bool _isLoading = false;

  String? _error;



  List<dynamic> get suivis => _suivis;

  bool get isLoading => _isLoading;

  String? get error => _error;



  // Charger suivis formation
  Future<void> fetchSuivis() async {

    try {

      _setLoading(true);


      _suivis =
          await _service.fetchSuivis();


      _error=null;


    } catch(e){

      _error=e.toString();


    } finally {

      _setLoading(false);

    }
  }



  // Modifier progression
  Future<void> updateProgression({
    required int suiviId,
    required int progression,
  }) async {

    try {

      await _service.updateProgression(
        suiviId: suiviId,
        progression: progression,
      );


      await fetchSuivis();


    } catch(e){

      _error=e.toString();

    }

  }



  void _setLoading(bool value){

    _isLoading=value;

    notifyListeners();

  }

}