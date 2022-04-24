import 'package:app_qldt/models/core/converter/generic_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable(createToJson: false)
class ResponseModel<T> {
  @GenericConverter()
  final T data;

  ResponseModel({required this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) => _$ResponseModelFromJson<T>(json);
}
