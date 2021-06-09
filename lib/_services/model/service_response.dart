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
      data = body['data'];
      version = body['data_version'];
    } on Error catch (e) {
      print(e);
    }
  }

  ServiceResponse.__(Response response){
    statusCode = response.statusCode;
    try {
      data = jsonDecode(response.body);
      version = -1;
    } on Error catch (e) {
      print(e);
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
