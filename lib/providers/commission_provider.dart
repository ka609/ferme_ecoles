import 'package:flutter/foundation.dart';

import '../services/commission_service.dart';


class CommissionProvider extends ChangeNotifier {

  final CommissionService _service = CommissionService();


  List<dynamic> _commissions = [];

  Map<String, dynamic>? _commissionDetail;


  bool _isLoading = false;

  String? _error;



  List<dynamic> get commissions => _commissions;

  Map<String, dynamic>? get commissionDetail =>
      _commissionDetail;


  bool get isLoading => _isLoading;

  String? get error => _error;



  // Charger commissions
  Future<void> fetchCommissions() async {

    try {

      _setLoading(true);


      _commissions =
          await _service.fetchCommissions();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Charger détail commission
  Future<void> fetchCommissionDetail(
    int commissionId,
  ) async {

    try {

      _setLoading(true);


      _commissionDetail =
          await _service.fetchCommissionDetail(
            commissionId,
          );


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

    _commissions.clear();

    _commissionDetail = null;

    _error = null;


    notifyListeners();

  }

}