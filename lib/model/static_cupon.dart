import 'dart:convert';

class ModelStaticCupon {
  int? statusCode;
  String? msm;
  double? cantCuponVn;
  double? disponibleCuponVn;
  int? totVn;
  double? cantCuponOcp;
  double? disponibleCuponOcp;
  int? totOcp;

  ModelStaticCupon({
    this.statusCode,
    this.msm,
    this.cantCuponVn,
    this.disponibleCuponVn,
    this.totVn,
    this.cantCuponOcp,
    this.disponibleCuponOcp,
    this.totOcp,
  });

  factory ModelStaticCupon.fromRawJson(String str) =>
      ModelStaticCupon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelStaticCupon.fromJson(Map<String, dynamic> json) =>
      ModelStaticCupon(
        statusCode: json["status_code"],
        msm: json["msm"],
        cantCuponVn: json["cant_cupon_vn"],
        disponibleCuponVn: json["disponible_cupon_vn"],
        totVn: json["tot_vn"],
        cantCuponOcp: json["cant_cupon_ocp"],
        disponibleCuponOcp: json["disponible_cupon_ocp"],
        totOcp: json["tot_ocp"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "msm": msm,
        "cant_cupon_vn": cantCuponVn,
        "disponible_cupon_vn": disponibleCuponVn,
        "tot_vn": totVn,
        "cant_cupon_ocp": cantCuponOcp,
        "disponible_cupon_ocp": disponibleCuponOcp,
        "tot_ocp": totOcp,
      };
}
