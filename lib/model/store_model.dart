import 'dart:convert';

class StorageModel {
  String? downloadUrl;

  StorageModel({
    this.downloadUrl,
  });

  factory StorageModel.fromRawJson(String str) =>
      StorageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StorageModel.fromJson(Map<String, dynamic> json) => StorageModel(
        downloadUrl: json["downloadURL"],
      );

  Map<String, dynamic> toJson() => {
        "downloadURL": downloadUrl,
      };
}
