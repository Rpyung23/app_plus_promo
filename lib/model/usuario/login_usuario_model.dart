import 'dart:convert';

import 'data_login_usuario_model.dart';

class LoginUsuarioModel {
  int? statusCode;
  DataLoginUsuarioModel? data;
  String? msm;

  LoginUsuarioModel({
    this.statusCode,
    this.data,
    this.msm,
  });

  factory LoginUsuarioModel.fromRawJson(String str) =>
      LoginUsuarioModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginUsuarioModel.fromJson(Map<String, dynamic> json) =>
      LoginUsuarioModel(
        statusCode: json["status_code"],
        data: json["data"] == null
            ? null
            : DataLoginUsuarioModel.fromJson(json["data"]),
        msm: json["msm"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
        "msm": msm,
      };
}
