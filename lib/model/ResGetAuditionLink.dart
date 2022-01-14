
class ResGetAuditionLink {
  ResGetAuditionLink({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<ResGetAuditionLinkList> data;

  factory ResGetAuditionLink.fromJson(Map<String, dynamic> json) => ResGetAuditionLink(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["data"] == null ? null : List<ResGetAuditionLinkList>.from(json["data"].map((x) => ResGetAuditionLinkList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ResGetAuditionLinkList {
  ResGetAuditionLinkList({
    this.id,
    this.actorsId,
    this.auditionsLink,
    this.urltitle,
    this.flagDeleted,
    this.endEffDt,
  });

  int id;
  String actorsId;
  String auditionsLink;
  String urltitle;
  bool flagDeleted;
  DateTime endEffDt;

  factory ResGetAuditionLinkList.fromJson(Map<String, dynamic> json) => ResGetAuditionLinkList(
    id: json["ID"] == null ? null : json["ID"],
    actorsId: json["ActorsID"] == null ? null : json["ActorsID"],
    auditionsLink: json["AuditionsLink"] == null ? null : json["AuditionsLink"],
    urltitle: json["urltitle"] == null ? null : json["urltitle"],
    flagDeleted: json["FlagDeleted"] == null ? null : json["FlagDeleted"],
    endEffDt: json["EndEffDt"] == null ? null : DateTime.parse(json["EndEffDt"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id == null ? null : id,
    "ActorsID": actorsId == null ? null : actorsId,
    "AuditionsLink": auditionsLink == null ? null : auditionsLink,
    "urltitle": urltitle == null ? null : urltitle,
    "FlagDeleted": flagDeleted == null ? null : flagDeleted,
    "EndEffDt": endEffDt == null ? null : endEffDt.toIso8601String(),
  };
}
