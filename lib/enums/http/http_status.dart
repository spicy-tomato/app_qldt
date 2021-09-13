enum HttpResponseStatus {
  successfully,
  incorrectInformation,
  serverError,
  noInternetConnection,
}

HttpResponseStatus statusFromCode(int code) {
  switch (code) {
    case 200:
      return HttpResponseStatus.successfully;

    case 401:
      return HttpResponseStatus.incorrectInformation;

    default:
      return HttpResponseStatus.serverError;
  }
}

extension HttpResponseStatusExtension on HttpResponseStatus {
  bool get isSuccessfully => this == HttpResponseStatus.successfully;
}
