// To parse this JSON data, do
//
//     final getProjectTitleRes = getProjectTitleResFromJson(jsonString);

import 'dart:convert';

GetProjectTitleRes getProjectTitleResFromJson(String str) =>
    GetProjectTitleRes.fromJson(json.decode(str));

String getProjectTitleResToJson(GetProjectTitleRes data) =>
    json.encode(data.toJson());

class GetProjectTitleRes {
  GetProjectTitleRes({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory GetProjectTitleRes.fromJson(Map<String, dynamic> json) =>
      GetProjectTitleRes(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.requirementTitle,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.flagDeleted,
    this.endEffDt,
  });

  int id;
  String requirementTitle;
  int createdBy;
  DateTime createdOn;
  int updatedBy;
  DateTime updatedOn;
  bool flagDeleted;
  DateTime endEffDt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        requirementTitle: json["RequirementTitle"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        updatedBy: json["UpdatedBy"],
        updatedOn: DateTime.parse(json["UpdatedOn"]),
        flagDeleted: json["FlagDeleted"],
        endEffDt: DateTime.parse(json["EndEffDt"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "RequirementTitle": requirementTitle,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "UpdatedBy": updatedBy,
        "UpdatedOn": updatedOn.toIso8601String(),
        "FlagDeleted": flagDeleted,
        "EndEffDt": endEffDt.toIso8601String(),
      };
}
