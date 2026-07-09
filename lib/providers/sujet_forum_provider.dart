import 'package:flutter/foundation.dart';

import '../services/sujet_forum_service.dart';


class SujetForumProvider extends ChangeNotifier {

  final SujetForumService _service =
      SujetForumService();


  List<dynamic> _sujets = [];

  bool _isLoading = false;

  String? _error;



  List<dynamic> get sujets => _sujets;

  bool get isLoading => _isLoading;

  String? get error => _error;



  // Charger sujets forum
  Future<void> fetchSujets() async {

    try {

      _setLoading(true);


      _sujets =
          await _service.fetchSujets();


      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }
  }



  // Créer sujet forum
  Future<void> createSujet({
    required String titre,
    required String contenu,
  }) async {

    try {

      _setLoading(true);


      await _service.createSujet(
        titre: titre,
        contenu: contenu,
      );


      await fetchSujets();


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