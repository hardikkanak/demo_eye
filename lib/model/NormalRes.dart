
class NormalRes {
  NormalRes({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory NormalRes.fromJson(Map<String, dynamic> json) => NormalRes(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}
