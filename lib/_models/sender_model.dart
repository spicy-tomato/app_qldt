class SenderModel {
  int idSender;
  String senderName;
  int permission;

  SenderModel({required this.idSender, required this.senderName, required this.permission});

  factory SenderModel.fromJson(Map<String, dynamic> json) {
    return SenderModel(
      idSender: json['ID_Sender'],
      senderName: json['Sender_Name'],
      permission: json['permission'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_sender': idSender,
      'sender_name': senderName,
      'permission': permission,
    };
  }

  static List<SenderModel> fromList(List list){
    List<SenderModel> res = [];

    for (var item in list){
      res.add(SenderModel.fromJson(item));
    }

    return res;
  }
}
