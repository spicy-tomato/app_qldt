import 'dart:convert';

import 'package:http/http.dart';

class ServiceResponse {
  late final int? statusCode;
  late final int? version;
  late final dynamic data;

  ServiceResponse._(Response response) {
    statusCode = response.statusCode;

    try {
      Map<String, dynamic> body = jsonDecode(response.body);
      version = body['data_version'];
      data = body['data'];
    } on Exception catch (_) {}
  }

  ServiceResponse.__({
    required this.statusCode,
    required this.version,
    this.data,
  });

  ServiceResponse(Response response) : this._(response);

  ServiceResponse.error()
      : this.__(
          statusCode: 0,
          version: -1,
          data: null,
        );

  ServiceResponse.offline()
      : this.__(
          statusCode: -1,
          version: -1,
          data: null,
        );

  bool get isError => statusCode == 0 && version == -1 && data == null;

  bool get isOffline => statusCode == -1 && version == -1 && data == null;
}
