import '../core/constants/api_constants.dart';


String buildProduitImageUrl(String? image) {

  if (image == null || image.isEmpty) {
    return "";
  }


  if (image.startsWith("http")) {
    return image;
  }


  return "${ApiConstants.baseUrl}$image";
}





class ProduitImage {


  final int id;


  final String image;




  ProduitImage({

    required this.id,

    required this.image,

  });







  factory ProduitImage.fromJson(

    Map<String, dynamic> json,

  ) {


    return ProduitImage(


      id:
          json["id"] ?? 0,



      image:
          buildProduitImageUrl(
            json["image"],
          ),


    );


  }







  Map<String, dynamic> toJson() {


    return {


      "id":
          id,



      "image":
          image,


    };


  }


}