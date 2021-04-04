class UserNotification {
  final int idNotification;
  final String title;
  final String content;
  final String typez;
  final String sender;
  final DateTime? timeStart;
  final DateTime? timeEnd;
  final DateTime? expired;

  UserNotification({
    required this.idNotification,
    required this.title,
    required this.content,
    required this.typez,
    required this.sender,
    required this.timeStart,
    required this.timeEnd,
    required this.expired,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      idNotification: json['ID_Notification'],
      title: json['Title'],
      content: json['Content'],
      typez: json['Typez'],
      sender: json['Sender'],
      timeStart: json['Time_Start'] == null
          ? null
          : DateTime.tryParse(json['Time_Start']),
      timeEnd:
          json['Time_End'] == null ? null : DateTime.tryParse(json['Time_End']),
      expired:
          json['Expired'] == null ? null : DateTime.tryParse(json['Expired']),
    );
  }

  factory UserNotification.fromMap(Map<String, dynamic> map) {
    return UserNotification(
      idNotification: map['ID_Notification'],
      title: map['Title'],
      content: map['Content'],
      typez: map['Typez'],
      sender: map['Sender'],
      timeStart: DateTime.parse(map['Time_Start']),
      timeEnd: DateTime.parse(map['Time_End']),
      expired: DateTime.parse(map['Expired']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "ID_Notification": idNotification,
      "Title": title,
      "Content": content,
      "Typez": typez,
      "Sender": sender,
      "Time_Start": timeStart,
      "Time_End": timeEnd,
      "Expired": expired,
    };
  }

  String toString() {
    return "ID: $idNotification, tiêu đề: $title, nội dung: $content";
  }
}
