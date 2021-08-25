// To parse this JSON data, do
//
//     final addProjectTitleRes = addProjectTitleResFromJson(jsonString);

import 'dart:convert';

AddProjectTitleRes addProjectTitleResFromJson(String str) =>
    AddProjectTitleRes.fromJson(json.decode(str));

String addProjectTitleResToJson(AddProjectTitleRes data) =>
    json.encode(data.toJson());

class AddProjectTitleRes {
  AddProjectTitleRes({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory AddProjectTitleRes.fromJson(Map<String, dynamic> json) =>
      AddProjectTitleRes(
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
