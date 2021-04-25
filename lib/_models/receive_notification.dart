class ReceiveNotification {
  final int idNotification;
  final String title;
  final String content;
  final String typez;
  final int idSender;
  final DateTime? timeStart;
  final DateTime? timeEnd;
  final DateTime? expired;

  ReceiveNotification({
    required this.idNotification,
    required this.title,
    required this.content,
    required this.typez,
    required this.idSender,
    required this.timeStart,
    required this.timeEnd,
    required this.expired,
  });

  factory ReceiveNotification.fromJson(Map<String, dynamic> json) {
    return ReceiveNotification(
      idNotification: json['ID_Notification'],
      title: json['Title'],
      content: json['Content'],
      typez: json['Typez'],
      idSender: json['ID_Sender'],
      timeStart: json['Time_Start'] == null ? null : DateTime.tryParse(json['Time_Start']),
      timeEnd: json['Time_End'] == null ? null : DateTime.tryParse(json['Time_End']),
      expired: json['Expired'] == null ? null : DateTime.tryParse(json['Expired']),
    );
  }

  factory ReceiveNotification.fromMap(Map<String, dynamic> map) {
    return ReceiveNotification(
      idNotification: map['id_notification'],
      title: map['title'],
      content: map['content'],
      typez: map['typez'],
      idSender: map['id_sender'],
      timeStart: map['time_start'] == null ? null : DateTime.tryParse(map['time_start']),
      timeEnd: map['time_end'] == null ? null : DateTime.tryParse(map['time_end']),
      expired: map['expired'] == null ? null : DateTime.tryParse(map['expired']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id_notification": idNotification,
      "title": title,
      "content": content,
      "typez": typez,
      "id_sender": idSender,
      "time_start": timeStart,
      "time_end": timeEnd,
      "expired": expired,
    };
  }

  String toString() {
    return "ID: $idNotification, tiêu đề: $title, nội dung: $content, người gửi: $idSender";
  }

  static List<ReceiveNotification> fromList(List<dynamic> list){
    List<ReceiveNotification> res = [];

    for (var item in list){
      res.add(ReceiveNotification.fromJson(item));
    }

    return res;
  }
}
