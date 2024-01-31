import 'dart:convert';

class CuponQrModel {
  int? cupon;
  String? user;

  CuponQrModel({
    this.cupon,
    this.user,
  });

  factory CuponQrModel.fromRawJson(String str) =>
      CuponQrModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CuponQrModel.fromJson(Map<String, dynamic> json) => CuponQrModel(
        cupon: json["cupon"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "cupon": cupon,
        "user": user,
      };
}
