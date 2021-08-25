// To parse this JSON data, do
//
//     final updateRequirementRes = updateRequirementResFromJson(jsonString);

import 'dart:convert';

UpdateRequirementRes updateRequirementResFromJson(String str) =>
    UpdateRequirementRes.fromJson(json.decode(str));

String updateRequirementResToJson(UpdateRequirementRes data) =>
    json.encode(data.toJson());

class UpdateRequirementRes {
  UpdateRequirementRes({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory UpdateRequirementRes.fromJson(Map<String, dynamic> json) =>
      UpdateRequirementRes(
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
