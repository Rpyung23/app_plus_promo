import 'dart:convert';

class ResponseModel {
  int? statusCode;
  String? msm;

  ResponseModel({
    this.statusCode,
    this.msm,
  });

  factory ResponseModel.fromRawJson(String str) =>
      ResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        statusCode: json["status_code"],
        msm: json["msm"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "msm": msm,
      };
}
