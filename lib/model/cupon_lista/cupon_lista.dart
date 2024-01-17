import 'dart:convert';

import 'data_cupon_lista.dart';

class ListCuponModel {
  int? statusCode;
  List<DatoCuponLista>? datos;
  String? msm;

  ListCuponModel({
    this.statusCode,
    this.datos,
    this.msm,
  });

  factory ListCuponModel.fromRawJson(String str) =>
      ListCuponModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListCuponModel.fromJson(Map<String, dynamic> json) => ListCuponModel(
        statusCode: json["status_code"],
        datos: json["datos"] == null
            ? []
            : List<DatoCuponLista>.from(
                json["datos"]!.map((x) => DatoCuponLista.fromJson(x))),
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
