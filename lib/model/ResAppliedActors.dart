// To parse this JSON data, do
//
//     final resAppliedActors = resAppliedActorsFromJson(jsonString);

import 'dart:convert';

ResAppliedActors resAppliedActorsFromJson(String str) => ResAppliedActors.fromJson(json.decode(str));

String resAppliedActorsToJson(ResAppliedActors data) => json.encode(data.toJson());

class ResAppliedActors {
  ResAppliedActors({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<ResAppliedActorsList> data;

  factory ResAppliedActors.fromJson(Map<String, dynamic> json) {

    return ResAppliedActors(
      status: json["Status"] == null ? null : json["Status"],
      message: json["Message"] == null ? null : json["Message"],
      data: json["data"] == null || json["data"].toString() == '{}' ? null : List<ResAppliedActorsList>.from(json["data"].map((x) => ResAppliedActorsList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ResAppliedActorsList {
  ResAppliedActorsList({
    this.id,
    this.requirementId,
    this.actorsId,
    this.name,
    this.isSelected,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.flagDeleted,
    this.endEffDt,
    this.minimumBudget,
    this.tagMark,
    this.starRating,
    this.mobileNumber
  });

  int id;
  int requirementId;
  String actorsId;
  String name;
  bool isSelected;
  int createdBy;
  DateTime createdOn;
  int updatedBy;
  int minimumBudget;
  String tagMark;
  int starRating;
  DateTime updatedOn;
  bool flagDeleted;
  DateTime endEffDt;
  String mobileNumber;

  factory ResAppliedActorsList.fromJson(Map<String, dynamic> json) => ResAppliedActorsList(
    id: json["ID"] == null ? null : json["ID"],
    requirementId: json["RequirementID"] == null ? null : json["RequirementID"],
    actorsId: json["ActorsID"] == null ? null : json["ActorsID"],
    name: json["Name"] == null ? null : json["Name"],
    isSelected: json["IsSelected"] == null ? null : json["IsSelected"],
    createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"] == null ? null : json["UpdatedBy"],
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
    flagDeleted: json["FlagDeleted"] == null ? null : json["FlagDeleted"],
    endEffDt: json["EndEffDt"] == null ? null : DateTime.parse(json["EndEffDt"]),
    minimumBudget: json["MinimumBudget"] == null ? null : json["MinimumBudget"],
    tagMark: json["TagMark"] == null ? null : json["TagMark"],
    starRating: json["StarRating"] == null ? null : json["StarRating"],
    mobileNumber: json["MobileNumber"] == null ? null : json["MobileNumber"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "RequirementID": requirementId == null ? null : requirementId,
    "ActorsID": actorsId == null ? null : actorsId,
    "Name": name == null ? null : name,
    "IsSelected": isSelected == null ? null : isSelected,
    "CreatedBy": createdBy == null ? null : createdBy,
    "CreatedOn": createdOn == null ? null : createdOn.toIso8601String(),
    "UpdatedBy": updatedBy == null ? null : updatedBy,
    "UpdatedOn": updatedOn == null ? null : updatedOn.toIso8601String(),
    "FlagDeleted": flagDeleted == null ? null : flagDeleted,
    "EndEffDt": endEffDt == null ? null : endEffDt.toIso8601String(),
    "MobileNumber": mobileNumber == null ? null : mobileNumber,
  };
}
