import 'package:flutter/foundation.dart';

import '../services/formation_service.dart';
import '../models/formation_model.dart';



class FormationProvider extends ChangeNotifier {


  final FormationService _service =
      FormationService();



  List<Formation> _formations = [];


  Formation? _formationDetail;



  bool _isLoading = false;


  String? _error;





  List<Formation> get formations =>
      _formations;



  Formation? get formationDetail =>
      _formationDetail;



  bool get isLoading =>
      _isLoading;



  String? get error =>
      _error;








  // Charger formations

  Future<void> fetchFormations() async {


    try {


      _setLoading(true);



      final data =
          await _service.fetchFormations();



      _formations =
          data
              .map(
                (json) =>
                    Formation.fromJson(json),
              )
              .toList();



      _error = null;



    } catch(e){


      _error =
          e.toString();



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



      final data =
          await _service.fetchFormationDetail(
            formationId,
          );



      _formationDetail =
          Formation.fromJson(
            data,
          );



      _error = null;



    } catch(e){


      _error =
          e.toString();



    } finally {


      _setLoading(false);


    }


  }








  // Créer formation

  Future<bool> createFormation(
    Map<String,dynamic> data,
  ) async {


    try {


      _setLoading(true);



      final response =
          await _service.createFormation(
            data,
          );



      _formations.add(

        Formation.fromJson(
          response,
        ),

      );



      notifyListeners();



      return true;



    } catch(e){


      _error =
          e.toString();



      return false;



    } finally {


      _setLoading(false);


    }


  }







  void _setLoading(
    bool value,
  ){


    _isLoading =
        value;



    notifyListeners();


  }








  void clearError(){


    _error =
        null;



    notifyListeners();


  }







  void clear(){


    _formations.clear();



    _formationDetail =
        null;



    _error =
        null;



    notifyListeners();


  }


}