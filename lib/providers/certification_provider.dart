import 'package:flutter/foundation.dart';

import '../services/certification_service.dart';


class CertificationProvider extends ChangeNotifier {

  final CertificationService _service = CertificationService();



  List<dynamic> _certifications = [];

  Map<String, dynamic>? _certificationDetail;


  bool _isLoading = false;

  String? _error;



  List<dynamic> get certifications => _certifications;

  Map<String, dynamic>? get certificationDetail =>
      _certificationDetail;


  bool get isLoading => _isLoading;

  String? get error => _error;



  // Charger certifications
  Future<void> fetchCertifications() async {

    try {

      _setLoading(true);


      _certifications =
          await _service.fetchCertifications();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Créer certification
  Future<bool> createCertification(

    Map<String, dynamic> data

  ) async {

    try {

      _setLoading(true);


      final certification =
          await _service.createCertification(
            data,
          );


      _certifications.add(
        certification,
      );


      _error = null;


      notifyListeners();


      return true;


    } catch (e) {

      _error = e.toString();


      return false;


    } finally {

      _setLoading(false);

    }

  }



  // Modifier certification
  Future<bool> updateCertification({

    required int id,

    required Map<String, dynamic> data,

  }) async {

    try {

      _setLoading(true);


      final updated =
          await _service.updateCertification(
            id,
            data,
          );


      final index =
          _certifications.indexWhere(
            (item) => item["id"] == id,
          );


      if (index != -1) {

        _certifications[index] = updated;

      }


      _error = null;


      notifyListeners();


      return true;


    } catch (e) {

      _error = e.toString();


      return false;


    } finally {

      _setLoading(false);

    }

  }



  // Modifier état chargement
  void _setLoading(

    bool value

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

    _certifications = [];

    _certificationDetail = null;

    _error = null;


    notifyListeners();

  }

}