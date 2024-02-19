import 'dart:convert';

class DatoCategorieModel {
  int? idCategoria;
  String? detalleCategoria;

  DatoCategorieModel({
    this.idCategoria,
    this.detalleCategoria,
  });

  factory DatoCategorieModel.fromRawJson(String str) =>
      DatoCategorieModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatoCategorieModel.fromJson(Map<String, dynamic> json) =>
      DatoCategorieModel(
        idCategoria: json["id_categoria"],
        detalleCategoria: json["detalle_categoria"],
      );

  Map<String, dynamic> toJson() => {
        "id_categoria": idCategoria,
        "detalle_categoria": detalleCategoria,
      };
}
