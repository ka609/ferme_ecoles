import 'package:flutter/foundation.dart';

import '../models/commission_model.dart';
import '../services/commission_service.dart';


class CommissionProvider extends ChangeNotifier {

  final CommissionService _service =
      CommissionService();



  List<Commission> _commissions = [];

  Commission? _commissionDetail;


  bool _isLoading = false;

  String? _error;



  List<Commission> get commissions =>
      _commissions;


  Commission? get commissionDetail =>
      _commissionDetail;



  bool get isLoading =>
      _isLoading;


  String? get error =>
      _error;



  // Charger commissions
  Future<void> fetchCommissions() async {

    try {

      _setLoading(true);



      final data =
          await _service.fetchCommissions();



      _commissions =
          data
              .map<Commission>(
                (json) =>
                    Commission.fromJson(json),
              )
              .toList();



      _error = null;


      notifyListeners();



    } catch (e) {

      _error = e.toString();

      notifyListeners();


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



      final data =
          await _service.fetchCommissionDetail(
            commissionId,
          );



      _commissionDetail =
          Commission.fromJson(
            data,
          );



      _error = null;


      notifyListeners();



    } catch (e) {

      _error = e.toString();

      notifyListeners();


    } finally {

      _setLoading(false);

    }

  }





  // Calcul total commissions
  double get totalCommissions {

    return _commissions.fold<double>(
      0,
      (
        total,
        commission,
      ) =>
          total + commission.montant,
    );

  }





  // Filtrer commissions payées
  List<Commission> get commissionsPayees {

    return _commissions
        .where(
          (commission) =>
              commission.statut
                  .toUpperCase() ==
              "PAYEE",
        )
        .toList();

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

    _commissions = [];

    _commissionDetail = null;

    _error = null;


    notifyListeners();

  }

}