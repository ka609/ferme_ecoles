import 'package:flutter/foundation.dart';

import '../services/notification_service.dart';


class NotificationProvider extends ChangeNotifier {

  final NotificationService _service =
      NotificationService();



  List<dynamic> _notifications = [];


  bool _isLoading = false;

  String? _error;



  List<dynamic> get notifications =>
      _notifications;


  bool get isLoading =>
      _isLoading;


  String? get error =>
      _error;



  // Charger notifications
  Future<void> fetchNotifications() async {

    try {

      _setLoading(true);


      _notifications =
          await _service.fetchNotifications();


      _error = null;


    } catch (e) {

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Lire notification
  Future<bool> readNotification(
    int id,
  ) async {

    try {

      await _service.readNotification(
        id,
      );


      final index =
          _notifications.indexWhere(
            (item) => item["id"] == id,
          );


      if (index != -1) {

        _notifications[index]["lu"] = true;

      }


      notifyListeners();


      return true;


    } catch (e) {

      _error = e.toString();

      return false;

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

    _notifications.clear();

    _error = null;


    notifyListeners();

  }

}