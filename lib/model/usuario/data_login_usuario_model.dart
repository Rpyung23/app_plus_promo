import 'dart:convert';

class DataLoginUsuarioModel {
  String? emailUsuario;
  String? nombreUsuario;
  String? fotoUsuario;

  DataLoginUsuarioModel({
    this.emailUsuario,
    this.nombreUsuario,
    this.fotoUsuario,
  });

  factory DataLoginUsuarioModel.fromRawJson(String str) =>
      DataLoginUsuarioModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataLoginUsuarioModel.fromJson(Map<String, dynamic> json) =>
      DataLoginUsuarioModel(
        emailUsuario: json["email_usuario"],
        nombreUsuario: json["nombre_usuario"],
        fotoUsuario: json["foto_usuario"],
      );

  Map<String, dynamic> toJson() => {
        "email_usuario": emailUsuario,
        "nombre_usuario": nombreUsuario,
        "foto_usuario": fotoUsuario,
      };
}
