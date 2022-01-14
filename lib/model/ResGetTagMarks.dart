
class ResGetTagMarks {
  ResGetTagMarks({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<ResGetTagMarksList> data;

  factory ResGetTagMarks.fromJson(Map<String, dynamic> json) => ResGetTagMarks(
    status: json["Status"] == null ? null : json["Status"],
    message: json["Message"] == null ? null : json["Message"],
    data: json["data"] == null ? null : List<ResGetTagMarksList>.from(json["data"].map((x) => ResGetTagMarksList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status == null ? null : status,
    "Message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ResGetTagMarksList {
  ResGetTagMarksList({
    this.id,
    this.tagMarkName,
  });

  int id;
  String tagMarkName;

  factory ResGetTagMarksList.fromJson(Map<String, dynamic> json) => ResGetTagMarksList(
    id: json["Id"] == null ? null : json["Id"],
    tagMarkName: json["TagMarkName"] == null ? null : json["TagMarkName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id == null ? null : id,
    "TagMarkName": tagMarkName == null ? null : tagMarkName,
  };
}
