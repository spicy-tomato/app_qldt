enum LoginStatus { successful, failed }

class LoginResponse {
  final String message;
  final dynamic info;

  LoginResponse({this.message, this.info});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      info: json['info'],
    );
  }
}
