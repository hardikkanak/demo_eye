// To parse this JSON data, do
//
//     final deleteProjectTitleRes = deleteProjectTitleResFromJson(jsonString);

import 'dart:convert';

DeleteProjectTitleRes deleteProjectTitleResFromJson(String str) =>
    DeleteProjectTitleRes.fromJson(json.decode(str));

String deleteProjectTitleResToJson(DeleteProjectTitleRes data) =>
    json.encode(data.toJson());

class DeleteProjectTitleRes {
  DeleteProjectTitleRes({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory DeleteProjectTitleRes.fromJson(Map<String, dynamic> json) =>
      DeleteProjectTitleRes(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
