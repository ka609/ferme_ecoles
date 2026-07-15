import 'package:flutter/foundation.dart';

import '../services/sujet_forum_service.dart';
import '../models/sujet_forum_model.dart';



class SujetForumProvider extends ChangeNotifier {


  final SujetForumService _service =
      SujetForumService();



  List<SujetForum> _sujets = [];



  bool _isLoading = false;


  String? _error;





  List<SujetForum> get sujets =>
      _sujets;



  bool get isLoading =>
      _isLoading;



  String? get error =>
      _error;








  Future<void> fetchSujets() async {


    try {


      _setLoading(true);



      final data =
          await _service.fetchSujets();




      _sujets = data
          .map<SujetForum>(

            (json) => SujetForum.fromJson(

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



    } catch(e) {


      _error = e.toString();



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