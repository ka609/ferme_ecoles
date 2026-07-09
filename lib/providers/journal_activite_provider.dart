import 'package:flutter/foundation.dart';

import '../services/journal_activite_service.dart';


class JournalActiviteProvider extends ChangeNotifier {

  final JournalActiviteService _service =
      JournalActiviteService();



  List<dynamic> _journal = [];


  bool _isLoading = false;

  String? _error;



  List<dynamic> get journal => _journal;


  bool get isLoading => _isLoading;


  String? get error => _error;



  // Charger journal activité
  Future<void> fetchJournal() async {

    try {

      _setLoading(true);


      _journal =
          await _service.fetchJournal();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Mise à jour chargement
  void _setLoading(
    bool value,
  ) {

    _isLoading = value;

    notifyListeners();

  }



  // Nettoyer erreur
  void clearError() {

    _error = null;

    notifyListeners();

  }



  // Réinitialiser données
  void clear() {

    _journal.clear();

    _error = null;


    notifyListeners();

  }

}