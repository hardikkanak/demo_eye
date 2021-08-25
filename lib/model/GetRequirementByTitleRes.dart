// To parse this JSON data, do
//
//     final getRequirementByTitleRes = getRequirementByTitleResFromJson(jsonString);

import 'dart:convert';

GetRequirementByTitleRes getRequirementByTitleResFromJson(String str) =>
    GetRequirementByTitleRes.fromJson(json.decode(str));

String getRequirementByTitleResToJson(GetRequirementByTitleRes data) =>
    json.encode(data.toJson());

class GetRequirementByTitleRes {
  GetRequirementByTitleRes({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory GetRequirementByTitleRes.fromJson(Map<String, dynamic> json) =>
      GetRequirementByTitleRes(
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
    this.gender,
    this.minimumBudget,
    this.maximumBudget,
    this.ageFrom,
    this.ageTo,
    this.languages,
    this.shortDescription,
    this.longDescription,
    this.isOpen,
    this.requirementTitleId,
    this.categories,
    this.characterTitle,
  });

  int id;
  Gender gender;
  int minimumBudget;
  int maximumBudget;
  int ageFrom;
  int ageTo;
  String languages;
  String shortDescription;
  String longDescription;
  bool isOpen;
  int requirementTitleId;
  String categories;
  String characterTitle;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        gender: genderValues.map[json["Gender"]],
        minimumBudget: json["MinimumBudget"],
        maximumBudget: json["MaximumBudget"],
        ageFrom: json["AgeFrom"],
        ageTo: json["AgeTo"],
        languages: json["Languages"],
        shortDescription: json["ShortDescription"],
        longDescription: json["LongDescription"],
        isOpen: json["IsOpen"],
        requirementTitleId: json["RequirementTitleID"],
        categories: json["Categories"],
        characterTitle:
            json["CharacterTitle"] == null ? null : json["CharacterTitle"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Gender": genderValues.reverse[gender],
        "MinimumBudget": minimumBudget,
        "MaximumBudget": maximumBudget,
        "AgeFrom": ageFrom,
        "AgeTo": ageTo,
        "Languages": languages,
        "ShortDescription": shortDescription,
        "LongDescription": longDescription,
        "IsOpen": isOpen,
        "RequirementTitleID": requirementTitleId,
        "Categories": categories,
        "CharacterTitle": characterTitle == null ? null : characterTitle,
      };
}

enum Gender { MALE_FEMALE, FEMALE, MALE }

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE,
  "Male,Female": Gender.MALE_FEMALE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
