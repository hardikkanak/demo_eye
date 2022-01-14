
class ResCopyRequirement {
  ResCopyRequirement({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  String data;

  factory ResCopyRequirement.fromJson(Map<String, dynamic> json) => ResCopyRequirement(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "data": data == null ? null : data,
  };
}
