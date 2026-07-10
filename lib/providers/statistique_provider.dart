import 'package:flutter/foundation.dart';

import '../models/statistique_producteur_model.dart';
import '../services/statistique_service.dart';


class StatistiqueProvider extends ChangeNotifier {

  final StatistiqueService _service =
      StatistiqueService();


  StatistiqueProducteur?
      _statistique;


  bool _isLoading = false;

  String? _error;


  StatistiqueProducteur? get statistique =>
      _statistique;


  bool get isLoading =>
      _isLoading;


  String? get error =>
      _error;



  Future<void>
      fetchStatistiqueProducteur() async {

    try {

      _isLoading = true;

      notifyListeners();


      final data =
          await _service
              .fetchStatistiqueProducteur();


      _statistique =
          StatistiqueProducteur.fromJson(
            data,
          );


      _error = null;


    } catch (e) {

      _error = e.toString();

    } finally {

      _isLoading = false;

      notifyListeners();

    }
  }
}