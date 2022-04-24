import 'package:json_annotation/json_annotation.dart';

import 'converter/generic_converter.dart';

part 'simple_model.g.dart';

@JsonSerializable()
class SimpleModel<K, V> {
  @GenericConverter()
  final K id;

  @GenericConverter()
  final V name;

  SimpleModel({required this.id, required this.name});

  factory SimpleModel.fromJson(Map<String, dynamic> json) => _$SimpleModelFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleModelToJson(this);
}
