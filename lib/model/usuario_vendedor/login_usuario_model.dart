import 'dart:convert';

import 'data_login_usuario_model.dart';

class LoginClienteVendedorModel {
  int? statusCode;
  DataLoginClienteVendedorModel? data;
  String? msm;

  LoginClienteVendedorModel({
    this.statusCode,
    this.data,
    this.msm,
  });

  factory LoginClienteVendedorModel.fromRawJson(String str) =>
      LoginClienteVendedorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginClienteVendedorModel.fromJson(Map<String, dynamic> json) =>
      LoginClienteVendedorModel(
        statusCode: json["status_code"],
        data: json["data"] == null
            ? null
            : DataLoginClienteVendedorModel.fromJson(json["data"]),
        msm: json["msm"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
        "msm": msm,
      };
}
