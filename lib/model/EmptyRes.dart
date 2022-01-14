class EmptyRes {
  EmptyRes({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory EmptyRes.fromJson(Map<String, dynamic> json) => EmptyRes(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
  };
}