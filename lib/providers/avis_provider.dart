import 'package:flutter/material.dart';

import '../models/avis_model.dart';
import '../services/avis_service.dart';


class AvisProvider extends ChangeNotifier {


  final AvisService _service = AvisService();



  List<Avis> _avis = [];


  bool _isLoading = false;


  String? _error;




  List<Avis> get avis => _avis;


  bool get isLoading => _isLoading;


  String? get error => _error;







  // Charger les avis produit

  Future<void> fetchAvis({

    int? produitId,

  }) async {


    try {


      _setLoading(true);



      final data = await _service.fetchAvis(

        produitId: produitId,

      );



      _avis = data

          .map<Avis>(

            (json) => Avis.fromJson(json),

          )

          .toList();



      _error = null;



    } catch(e) {


      _error = e.toString();



    } finally {


      _setLoading(false);


    }


  }








  // Charger détail avis

  Future<Avis?> fetchAvisDetail(

    int avisId,

  ) async {


    try {


      final data =
          await _service.fetchAvisDetail(

            avisId,

          );



      return Avis.fromJson(data);



    } catch(e) {


      _error = e.toString();


      notifyListeners();


      return null;


    }


  }









  // Ajouter un avis

  Future<bool> createAvis({

    required int produitId,

    required int note,

    required String commentaire,

  }) async {


    try {


      _setLoading(true);



      await _service.createAvis(

        produitId: produitId,

        note: note,

        commentaire: commentaire,

      );



      await fetchAvis(

        produitId: produitId,

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









  // Modifier un avis

  Future<bool> updateAvis(

    int avisId,

    Map<String, dynamic> data,

  ) async {


    try {


      _setLoading(true);



      await _service.updateAvis(

        avisId,

        data,

      );



      await fetchAvis();



      return true;



    } catch(e) {


      _error = e.toString();


      notifyListeners();


      return false;



    } finally {


      _setLoading(false);


    }


  }









  // Supprimer un avis

  Future<bool> deleteAvis(

    int avisId,

  ) async {


    try {


      _setLoading(true);



      await _service.deleteAvis(

        avisId,

      );



      _avis.removeWhere(

        (item) => item.id == avisId,

      );



      notifyListeners();



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