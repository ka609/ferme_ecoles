import 'package:flutter/material.dart';

import '../models/utilisateur_model.dart';
import '../services/utilisateur_service.dart';


class UtilisateurProvider extends ChangeNotifier {

  final UtilisateurService _service =
      UtilisateurService();


  Utilisateur? _utilisateur;

  bool _isLoading = false;

  String? _error;


  Utilisateur? get utilisateur =>
      _utilisateur;


  bool get isLoading =>
      _isLoading;


  String? get error =>
      _error;



  // Charger profil utilisateur
  Future<void> fetchProfile() async {

    _setLoading(true);


    try {

      final data =
          await _service.getProfile();


      _utilisateur =
          Utilisateur.fromJson(
            data,
          );


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Modifier profil
  Future<bool> updateProfile(
    Map<String, dynamic> data,
  ) async {

    _setLoading(true);


    try {

      final response =
          await _service.updateProfile(
            data,
          );


      _utilisateur =
          Utilisateur.fromJson(
            response,
          );


      _error = null;

      notifyListeners();

      return true;


    } catch (e) {

      _error = e.toString();

      notifyListeners();

      return false;


    } finally {

      _setLoading(false);

    }

  }



  // Etat chargement
  void _setLoading(
    bool value,
  ){

    _isLoading = value;

    notifyListeners();

  }

}