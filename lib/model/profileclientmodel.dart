import 'dart:convert';

class ProfileClientModel {
  int? statusCode;
  String? msm;
  DataProfileClient? datos;

  ProfileClientModel({
    this.statusCode,
    this.msm,
    this.datos,
  });

  factory ProfileClientModel.fromRawJson(String str) =>
      ProfileClientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileClientModel.fromJson(Map<String, dynamic> json) =>
      ProfileClientModel(
        statusCode: json["status_code"],
        msm: json["msm"],
        datos: json["datos"] == null
            ? null
            : DataProfileClient.fromJson(json["datos"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "msm": msm,
        "datos": datos?.toJson(),
      };
}

class DataProfileClient {
  String? nameCliente;
  String? fotoCliente;
  String? uidCliente;

  DataProfileClient({
    this.nameCliente,
    this.fotoCliente,
    this.uidCliente,
  });

  factory DataProfileClient.fromRawJson(String str) =>
      DataProfileClient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataProfileClient.fromJson(Map<String, dynamic> json) =>
      DataProfileClient(
        nameCliente: json["name_cliente"],
        fotoCliente: json["foto_cliente"],
        uidCliente: json["uid_cliente"],
      );

  Map<String, dynamic> toJson() => {
        "name_cliente": nameCliente,
        "foto_cliente": fotoCliente,
        "uid_cliente": uidCliente,
      };
}
