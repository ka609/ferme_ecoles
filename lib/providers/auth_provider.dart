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

    debugPrint("LOGIN : $username");


    try {

      final data = await _service.login(
        username,
        password,
      );


      debugPrint("LOGIN RESPONSE : $data");


      await TokenManager.saveTokens(
        access: data["access"],
        refresh: data["refresh"],
      );


      debugPrint("TOKEN ENREGISTRE");


      _user = Utilisateur.fromJson(
        data["user"],
      );


      debugPrint(
        "UTILISATEUR CONNECTE : ${_user?.username}",
      );


      _error = null;

      notifyListeners();

      return true;


    } catch (e) {

      debugPrint(
        "LOGIN ERROR : $e",
      );


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


    debugPrint(
      "REGISTER DATA : $data",
    );


    try {

      final response =
          await _service.register(
            data,
          );


      debugPrint(
        "REGISTER RESPONSE : $response",
      );


      _error = null;


      // Connexion automatique après inscription réussie
      // pour permettre la redirection selon le rôle (GoRouter)

      final username =
          data["username"] as String;

      final password =
          data["password"] as String;


      final loginSuccess = await login(
        username,
        password,
      );


      debugPrint(
        "AUTO-LOGIN APRES REGISTER : $loginSuccess",
      );


      return loginSuccess;


    } catch (e) {

      debugPrint(
        "REGISTER ERROR : $e",
      );


      _error = e.toString();

      notifyListeners();

      return false;


    } finally {

      _setLoading(false);

    }
  }



  // Chargement profil connecté
  Future<void> loadUser() async {

    debugPrint(
      "CHARGEMENT PROFIL",
    );


    try {

      final data =
          await _service.fetchMe();


      debugPrint(
        "PROFILE RESPONSE : $data",
      );


      _user = Utilisateur.fromJson(
        data,
      );


      debugPrint(
        "USER ACTUEL : ${_user?.username}",
      );


      notifyListeners();


    } catch (e) {

      debugPrint(
        "PROFILE ERROR : $e",
      );


      await logout();

    }

  }



  // Déconnexion
  Future<void> logout() async {

    debugPrint(
      "DECONNEXION",
    );


    await TokenManager.clearTokens();


    _user = null;

    notifyListeners();

  }



  // Mise à jour état chargement
  void _setLoading(
    bool value,
  ){

    _isLoading = value;

    notifyListeners();

  }

}