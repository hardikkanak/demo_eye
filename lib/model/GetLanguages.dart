// To parse this JSON data, do
//
//     final getLanguages = getLanguagesFromJson(jsonString);

import 'dart:convert';

GetLanguages getLanguagesFromJson(String str) => GetLanguages.fromJson(json.decode(str));

String getLanguagesToJson(GetLanguages data) => json.encode(data.toJson());

class GetLanguages {
  GetLanguages({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<GetLanguageList> data;

  factory GetLanguages.fromJson(Map<String, dynamic> json) => GetLanguages(
    status: json["Status"],
    message: json["Message"],
    data: List<GetLanguageList>.from(json["data"].map((x) => GetLanguageList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetLanguageList {
  GetLanguageList({
    this.id,
    this.languageName,
  });

  int id;
  String languageName;

  factory GetLanguageList.fromJson(Map<String, dynamic> json) => GetLanguageList(
    id: json["Id"],
    languageName: json["LanguageName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "LanguageName": languageName,
  };
}
