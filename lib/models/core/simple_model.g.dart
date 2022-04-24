// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleModel<K, V> _$SimpleModelFromJson<K, V>(Map<String, dynamic> json) =>
    SimpleModel<K, V>(
      id: GenericConverter<K>().fromJson(json['id']),
      name: GenericConverter<V>().fromJson(json['name']),
    );

Map<String, dynamic> _$SimpleModelToJson<K, V>(SimpleModel<K, V> instance) =>
    <String, dynamic>{
      'id': GenericConverter<K>().toJson(instance.id),
      'name': GenericConverter<V>().toJson(instance.name),
    };
