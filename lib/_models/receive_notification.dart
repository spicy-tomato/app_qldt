class ReceiveNotification {
  final int idNotification;
  final String title;
  final String content;
  final String typez;
  final int idSender;
  final DateTime timeCreated;
  final DateTime? timeStart;
  final DateTime? timeEnd;

  ReceiveNotification({
    required this.idNotification,
    required this.title,
    required this.content,
    required this.typez,
    required this.idSender,
    required this.timeStart,
    required this.timeEnd,
    required this.timeCreated,
  });

  factory ReceiveNotification.fromJson(Map<String, dynamic> json) {
    return ReceiveNotification(
      idNotification: json['ID_Notification'],
      title: json['Title'],
      content: json['Content'],
      typez: json['Typez'],
      idSender: json['ID_Sender'],
      timeCreated: DateTime.parse(json['Time_Create']),
      timeStart: json['Time_Start'] == null ? null : DateTime.tryParse(json['Time_Start']),
      timeEnd: json['Time_End'] == null ? null : DateTime.tryParse(json['Time_End']),
    );
  }

  factory ReceiveNotification.fromMap(Map<String, dynamic> map) {
    return ReceiveNotification(
      idNotification: map['id_notification'],
      title: map['title'],
      content: map['content'],
      typez: map['typez'],
      idSender: map['id_sender'],
      timeCreated: DateTime.parse(map['time_created']),
      timeStart: map['time_start'] == null ? null : DateTime.tryParse(map['time_start']),
      timeEnd: map['time_end'] == null ? null : DateTime.tryParse(map['time_end']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_notification': idNotification,
      'title': title,
      'content': content,
      'typez': typez,
      'id_sender': idSender,
      'time_created': timeCreated.toIso8601String(),
      'time_start': timeStart == null ? null : timeStart!.toIso8601String(),
      'time_end': timeEnd == null ? null : timeEnd!.toIso8601String(),
    };
  }

  String toString() {
    return 'ID: $idNotification, tiêu đề: $title, nội dung: $content, người gửi: $idSender';
  }

  static List<ReceiveNotification> fromList(List<dynamic> list){
    List<ReceiveNotification> res = [];

    for (var item in list){
      res.add(ReceiveNotification.fromJson(item));
    }

    return res;
  }
}
