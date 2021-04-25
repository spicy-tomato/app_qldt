class Sender {
  int idSender;
  String senderName;
  int permission;

  Sender({required this.idSender, required this.senderName, required this.permission});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      idSender: json['ID_Sender'],
      senderName: json['Sender_Name'],
      permission: json['Permission'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_sender': idSender,
      'sender_name': senderName,
      'permission': permission,
    };
  }

  static List<Sender> fromList(List<dynamic> list){
    List<Sender> res = [];

    for (var item in list){
      res.add(Sender.fromJson(item));
    }

    return res;
  }
}
