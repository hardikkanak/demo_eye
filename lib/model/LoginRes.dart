// To parse this JSON data, do
//
//     final loginRes = loginResFromJson(jsonString);

import 'dart:convert';

LoginRes loginResFromJson(String str) => LoginRes.fromJson(json.decode(str));

String loginResToJson(LoginRes data) => json.encode(data.toJson());

class LoginRes {
  LoginRes({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
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
  Data({
    this.accesstoken,
    this.tokenType,
  });

  String accesstoken;
  String tokenType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accesstoken: json["Accesstoken"],
        tokenType: json["Token_type"],
      );

  Map<String, dynamic> toJson() => {
        "Accesstoken": accesstoken,
        "Token_type": tokenType,
      };
}
