import 'package:flutter/foundation.dart';

import '../services/reponse_forum_service.dart';


class ReponseForumProvider extends ChangeNotifier {

  final ReponseForumService _service = ReponseForumService();


  List<dynamic> _reponses = [];

  bool _isLoading = false;

  String? _error;


  List<dynamic> get reponses => _reponses;

  bool get isLoading => _isLoading;

  String? get error => _error;



  // Charger réponses sujet
  Future<void> fetchReponses(
    int sujetId,
  ) async {

    try {

      _setLoading(true);

      _reponses =
          await _service.fetchReponses(
            sujetId,
          );

      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }
  }



  // Créer réponse
  Future<void> createReponse({
    required int sujetId,
    required String contenu,
  }) async {

    try {

      _setLoading(true);


      await _service.createReponse(
        sujetId: sujetId,
        contenu: contenu,
      );


      await fetchReponses(sujetId);


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