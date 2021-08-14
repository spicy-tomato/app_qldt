import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class ServiceResponse {
  late final int? statusCode;
  late final int? version;
  late final dynamic data;

  ServiceResponse._(Response response) {
    statusCode = response.statusCode;

    if (statusCode == 204) {
      version = -1;
      data = null;
    } else {
      try {
        Map<String, dynamic> body = jsonDecode(response.body);
        data = body['data'];
        version = body['data_version'];
      } on Exception catch (e) {
        debugPrint('$e in ServiceResponse._()');
      }
    }
  }

  ServiceResponse.__(Response response) {
    statusCode = response.statusCode;
    version = -1;
    try {
      data = jsonDecode(response.body);
    } on Exception catch (_) {
      data = null;
    }
  }

  ServiceResponse.___({
    required this.statusCode,
    required this.version,
    this.data,
  });

  ServiceResponse(Response response) : this.__(response);

  ServiceResponse.withVersion(Response response) : this._(response);

  ServiceResponse.error()
      : this.___(
          statusCode: 0,
          version: -1,
          data: null,
        );

  ServiceResponse.offline()
      : this.___(
          statusCode: -1,
          version: -1,
          data: null,
        );

  bool get isError => statusCode == 0 && version == -1 && data == null;

  bool get isOffline => statusCode == -1 && version == -1 && data == null;
}
