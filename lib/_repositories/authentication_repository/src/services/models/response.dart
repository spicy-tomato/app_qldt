enum LoginStatus {
  successfully,
  incorrectInformation,
  serverError,
  noInternetConnection,
}

LoginStatus statusFromCode(int code) {
  switch (code) {
    case 200:
      return LoginStatus.successfully;

    case 401:
      return LoginStatus.incorrectInformation;

    default:
      return LoginStatus.serverError;
  }
}

class LoginResponse {
  final LoginStatus status;
  final String? data;

  LoginResponse({
    required this.status,
    this.data,
  });
}
