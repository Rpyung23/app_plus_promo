import 'dart:convert';

class DatoCuponLista {
  int? codeCupon;
  String? nombreCupon;
  String? porcetajeDescuento;
  String? fechaExpiracion;
  int? cantCupon;
  int? disponible_cupon;
  String? fotoCupon;

  DatoCuponLista(
      {this.codeCupon,
      this.nombreCupon,
      this.porcetajeDescuento,
      this.fechaExpiracion,
      this.cantCupon,
      this.fotoCupon,
      this.disponible_cupon});

  factory DatoCuponLista.fromRawJson(String str) =>
      DatoCuponLista.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoCuponLista.fromJson(Map<String, dynamic> json) => DatoCuponLista(
      codeCupon: json["code_cupon"],
      nombreCupon: json["nombre_cupon"],
      porcetajeDescuento: json["porcetaje_descuento"],
      fechaExpiracion:
          json["fecha_expiracion"] == null ? null : json["fecha_expiracion"],
      cantCupon: json["cant_cupon"],
      fotoCupon: json["foto_cupon"],
      disponible_cupon:
          json["disponible_cupon"] == null ? 0 : json["disponible_cupon"]);

  Map<String, dynamic> toJson() => {
        "code_cupon": codeCupon,
        "nombre_cupon": nombreCupon,
        "porcetaje_descuento": porcetajeDescuento,
        "fecha_expiracion": fechaExpiracion,
        "cant_cupon": cantCupon,
        "foto_cupon": fotoCupon,
        "disponible_cupon": disponible_cupon
      };
}
