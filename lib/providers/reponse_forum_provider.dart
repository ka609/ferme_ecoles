import 'package:flutter/foundation.dart';

import '../services/reponse_forum_service.dart';
import '../models/reponse_forum_model.dart';


class ReponseForumProvider extends ChangeNotifier {


  final ReponseForumService _service =
      ReponseForumService();



  List<ReponseForum> _reponses = [];


  bool _isLoading = false;


  String? _error;




  List<ReponseForum> get reponses =>
      _reponses;



  bool get isLoading =>
      _isLoading;



  String? get error =>
      _error;






  Future<void> fetchReponses(

    int sujetId,

  ) async {


    try {


      _setLoading(true);



      final data =
          await _service.fetchReponses(
            sujetId,
          );



      _reponses = data
          .map<ReponseForum>(
            (json) => ReponseForum.fromJson(
              Map<String, dynamic>.from(json),
            ),
          )
          .toList();



      _error = null;



    } catch(e) {


      _error = e.toString();



    } finally {


      _setLoading(false);


    }


  }







  Future<bool> createReponse({

    required int sujetId,

    required String contenu,

  }) async {


    try {


      _setLoading(true);



      await _service.createReponse(

        sujetId: sujetId,

        contenu: contenu,

      );



      await fetchReponses(
        sujetId,
      );



      return true;



    } catch(e) {


      _error = e.toString();


      notifyListeners();


      return false;



    } finally {


      _setLoading(false);


    }


  }







  void _setLoading(

    bool value,

  ){


    _isLoading = value;


    notifyListeners();


  }







  void clearError(){


    _error = null;


    notifyListeners();


  }


}