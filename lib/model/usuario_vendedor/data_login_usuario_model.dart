import 'dart:convert';

class DataLoginClienteVendedorModel {
  String? email;
  String? name;
  String? foto;

  DataLoginClienteVendedorModel({
    this.email,
    this.name,
    this.foto,
  });

  factory DataLoginClienteVendedorModel.fromRawJson(String str) =>
      DataLoginClienteVendedorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataLoginClienteVendedorModel.fromJson(Map<String, dynamic> json) =>
      DataLoginClienteVendedorModel(
        email: json["email"],
        name: json["name"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "foto": foto,
      };
}
