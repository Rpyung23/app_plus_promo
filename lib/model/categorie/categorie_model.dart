import 'dart:convert';

import 'data_categorie_model.dart';

class ModelCategorie {
  int? statusCode;
  List<DatoCategorieModel>? datos;
  String? msm;

  ModelCategorie({
    this.statusCode,
    this.datos,
    this.msm,
  });

  factory ModelCategorie.fromRawJson(String str) =>
      ModelCategorie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelCategorie.fromJson(Map<String, dynamic> json) => ModelCategorie(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? []
            : List<DatoCategorieModel>.from(
                json["datos"]!.map((x) => DatoCategorieModel.fromJson(x))),
        msm: json["msm"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datos": datos == null
            ? []
            : List<dynamic>.from(datos!.map((x) => x.toJson())),
        "msm": msm,
      };
}
