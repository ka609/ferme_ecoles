class NotificationModel {

  final int id;

  final String titre;

  final String message;

  final bool lu;

  final DateTime? date;



  NotificationModel({

    required this.id,

    required this.titre,

    required this.message,

    required this.lu,

    this.date,

  });




  factory NotificationModel.fromJson(

    Map<String, dynamic> json,

  ) {

    return NotificationModel(

      id: json["id"],

      titre: json["titre"] ?? "",

      message: json["message"] ?? "",

      lu: json["lu"] ?? false,

      date: json["date"] != null

          ? DateTime.parse(json["date"])

          : null,

    );

  }






  Map<String, dynamic> toJson() {

    return {

      "id": id,

      "titre": titre,

      "message": message,

      "lu": lu,

      "date": date?.toIso8601String(),

    };

  }







  NotificationModel copyWith({

    int? id,

    String? titre,

    String? message,

    bool? lu,

    DateTime? date,

  }) {

    return NotificationModel(

      id: id ?? this.id,

      titre: titre ?? this.titre,

      message: message ?? this.message,

      lu: lu ?? this.lu,

      date: date ?? this.date,

    );

  }


}