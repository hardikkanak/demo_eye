// To parse this JSON data, do
//
//     final updateProjectTitleRes = updateProjectTitleResFromJson(jsonString);

import 'dart:convert';

UpdateProjectTitleRes updateProjectTitleResFromJson(String str) =>
    UpdateProjectTitleRes.fromJson(json.decode(str));

String updateProjectTitleResToJson(UpdateProjectTitleRes data) =>
    json.encode(data.toJson());

class UpdateProjectTitleRes {
  UpdateProjectTitleRes({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory UpdateProjectTitleRes.fromJson(Map<String, dynamic> json) =>
      UpdateProjectTitleRes(
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
