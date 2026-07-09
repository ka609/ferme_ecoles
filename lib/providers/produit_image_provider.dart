import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../services/produit_image_service.dart';


class ProduitImageProvider extends ChangeNotifier {

  final ProduitImageService _service =
      ProduitImageService();



  List<dynamic> _images = [];


  bool _isLoading = false;

  String? _error;



  List<dynamic> get images =>
      _images;


  bool get isLoading =>
      _isLoading;


  String? get error =>
      _error;



  // Charger images
  Future<void> fetchImages() async {

    try {

      _setLoading(true);


      _images =
          await _service.fetchImages();


      _error = null;


    } catch(e){

      _error = e.toString();


    } finally {

      _setLoading(false);

    }

  }



  // Ajouter image
  Future<bool> uploadImage({
    required int produitId,
    required MultipartFile image,
  }) async {

    try {

      final imageData =
          await _service.uploadImage(
            produitId: produitId,
            image: image,
          );


      _images.add(
        imageData,
      );


      notifyListeners();


      return true;


    } catch(e){

      _error = e.toString();

      return false;

    }

  }



  // Supprimer image
  Future<bool> deleteImage(
    int imageId,
  ) async {

    try {

      await _service.deleteImage(
        imageId,
      );


      _images.removeWhere(
        (item) =>
            item["id"] == imageId,
      );


      notifyListeners();


      return true;


    } catch(e){

      _error = e.toString();

      return false;

    }

  }



  // Mise à jour chargement
  void _setLoading(
    bool value,
  ){

    _isLoading = value;

    notifyListeners();

  }



  // Nettoyer erreur
  void clearError(){

    _error = null;

    notifyListeners();

  }



  // Réinitialiser données
  void clear(){

    _images.clear();

    _error = null;


    notifyListeners();

  }

}