class UserNotificationModel {
  final int idNotification;
  final String title;
  final String content;
  final String typez;
  final String senderName;
  final DateTime timeCreated;
  final DateTime? timeStart;
  final DateTime? timeEnd;

  UserNotificationModel({
    required this.idNotification,
    required this.title,
    required this.content,
    required this.typez,
    required this.senderName,
    required this.timeStart,
    required this.timeEnd,
    required this.timeCreated,
  });

  factory UserNotificationModel.fromMap(Map<String, dynamic> map) {
    return UserNotificationModel(
      idNotification: map['id_notification'],
      title: map['title'],
      content: map['content'],
      typez: map['typez'],
      senderName: map['sender_name'],
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
      'id_sender': senderName,
      'time_created': timeCreated,
      'time_start': timeStart,
      'time_end': timeEnd,
    };
  }

  @override
  String toString() {
    return 'ID: $idNotification, tiêu đề: $title, nội dung: $content, người gửi: $senderName';
  }
}
