// To parse this JSON data, do
//
//     final deleteRequirementRes = deleteRequirementResFromJson(jsonString);

import 'dart:convert';

DeleteRequirementRes deleteRequirementResFromJson(String str) =>
    DeleteRequirementRes.fromJson(json.decode(str));

String deleteRequirementResToJson(DeleteRequirementRes data) =>
    json.encode(data.toJson());

class DeleteRequirementRes {
  DeleteRequirementRes({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory DeleteRequirementRes.fromJson(Map<String, dynamic> json) =>
      DeleteRequirementRes(
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
