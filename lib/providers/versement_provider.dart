import 'package:flutter/foundation.dart';

import '../models/versement_model.dart';
import '../services/versement_service.dart';



class VersementProvider extends ChangeNotifier {


  final VersementService _service =
      VersementService();



  List<Versement> _versements = [];


  Versement? _detail;



  bool _isLoading = false;


  String? _error;





  List<Versement> get versements =>
      _versements;



  Versement? get detail =>
      _detail;



  bool get isLoading =>
      _isLoading;



  String? get error =>
      _error;








  // Charger versements

  Future<void> fetchVersements() async {


    try {


      _setLoading(true);



      final data =
          await _service.fetchVersements();




      _versements =
          data
              .map<Versement>(
                (json) =>
                    Versement.fromJson(json),
              )
              .toList();



      _error = null;



    } catch(e){


      _error = e.toString();



    } finally {


      _setLoading(false);


    }


  }








  // Détail versement

  Future<void> fetchVersementDetail(

    int versementId,

  ) async {



    try {


      _setLoading(true);



      final data =
          await _service.fetchVersementDetail(
            versementId,
          );



      _detail =
          Versement.fromJson(data);



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