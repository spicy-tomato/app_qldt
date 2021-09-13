import 'package:app_qldt/enums/http/http_status.dart';

class HttpResponseModel {
  final HttpResponseStatus status;
  final String? data;

  HttpResponseModel({
    required this.status,
    this.data,
  });
}
