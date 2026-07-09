import 'package:flutter/material.dart';

import '../models/utilisateur_model.dart';
import '../services/auth_service.dart';
import '../services/token_manager.dart';


class AuthProvider extends ChangeNotifier {

  final AuthService _service = AuthService();

  Utilisateur? _user;

  bool _isLoading = false;

  String? _error;


  Utilisateur? get user => _user;

  bool get isLoading => _isLoading;

  bool get isAuthenticated => _user != null;

  String? get error => _error;



  // Connexion utilisateur
  Future<bool> login(
    String username,
    String password,
  ) async {

    _setLoading(true);


    try {

      final data = await _service.login(
        username,
        password,
      );


      await TokenManager.saveTokens(
        access: data["access"],
        refresh: data["refresh"],
      );


      _user = Utilisateur.fromJson(
        data["user"],
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



  // Inscription utilisateur
  Future<bool> register(
    Map<String, dynamic> data,
  ) async {

    _setLoading(true);


    try {

      await _service.register(
        data,
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



  // Chargement profil connecté
  Future<void> loadUser() async {

    try {

      final data = await _service.fetchMe();


      _user = Utilisateur.fromJson(
        data,
      );


      notifyListeners();


    } catch (e) {

      logout();

    }

  }



  // Déconnexion
  Future<void> logout() async {

    await TokenManager.clearTokens();


    _user = null;

    notifyListeners();

  }



  // Mise à jour état chargement
  void _setLoading(
    bool value
  ){

    _isLoading = value;

    notifyListeners();

  }

}