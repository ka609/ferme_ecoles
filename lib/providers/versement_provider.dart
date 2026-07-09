import 'package:flutter/foundation.dart';

import '../services/versement_service.dart';


class VersementProvider extends ChangeNotifier {

  final VersementService _service =
      VersementService();



  List<dynamic> _versements = [];

  Map<String,dynamic>? _detail;


  bool _isLoading = false;

  String? _error;



  List<dynamic> get versements => _versements;

  Map<String,dynamic>? get detail => _detail;

  bool get isLoading => _isLoading;

  String? get error => _error;



  // Charger versements
  Future<void> fetchVersements() async {

    try {

      _setLoading(true);


      _versements =
          await _service.fetchVersements();


      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }
  }



  // Charger détail versement
  Future<void> fetchVersementDetail(
    int versementId,
  ) async {

    try {

      _setLoading(true);


      _detail =
          await _service.fetchVersementDetail(
            versementId,
          );


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

}