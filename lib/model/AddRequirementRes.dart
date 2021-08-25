// To parse this JSON data, do
//
//     final addRequirementRes = addRequirementResFromJson(jsonString);

import 'dart:convert';

AddRequirementRes addRequirementResFromJson(String str) =>
    AddRequirementRes.fromJson(json.decode(str));

String addRequirementResToJson(AddRequirementRes data) =>
    json.encode(data.toJson());

class AddRequirementRes {
  AddRequirementRes({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory AddRequirementRes.fromJson(Map<String, dynamic> json) =>
      AddRequirementRes(
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
