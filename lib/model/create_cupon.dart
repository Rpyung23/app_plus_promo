import 'dart:convert';

class CreateCuponModel {
  int? statusCode;
  String? msm;

  CreateCuponModel({
    this.statusCode,
    this.msm,
  });

  factory CreateCuponModel.fromRawJson(String str) =>
      CreateCuponModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateCuponModel.fromJson(Map<String, dynamic> json) =>
      CreateCuponModel(
        statusCode: json["status_code"],
        msm: json["msm"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "msm": msm,
      };
}
