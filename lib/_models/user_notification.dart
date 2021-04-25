class UserNotification {
  final int idNotification;
  final String title;
  final String content;
  final String typez;
  final String senderName;
  final DateTime? timeStart;
  final DateTime? timeEnd;
  final DateTime? expired;

  UserNotification({
    required this.idNotification,
    required this.title,
    required this.content,
    required this.typez,
    required this.senderName,
    required this.timeStart,
    required this.timeEnd,
    required this.expired,
  });

  factory UserNotification.fromMap(Map<String, dynamic> map) {
    return UserNotification(
      idNotification: map['id_notification'],
      title: map['title'],
      content: map['content'],
      typez: map['typez'],
      senderName: map['sender_name'],
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
      "id_sender": senderName,
      "time_start": timeStart,
      "time_end": timeEnd,
      "expired": expired,
    };
  }

  String toString() {
    return "ID: $idNotification, tiêu đề: $title, nội dung: $content, người gửi: $senderName";
  }
}
