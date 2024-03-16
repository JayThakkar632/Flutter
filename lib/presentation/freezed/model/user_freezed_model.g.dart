// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_freezed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserFreezedModelImpl _$$UserFreezedModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserFreezedModelImpl(
      json['id'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$$UserFreezedModelImplToJson(
        _$UserFreezedModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$DataImpl _$$DataImplFromJson(Map<String, dynamic> json) => _$DataImpl(
      json['value'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DataImplToJson(_$DataImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'runtimeType': instance.$type,
    };

_$LoadingImpl _$$LoadingImplFromJson(Map<String, dynamic> json) =>
    _$LoadingImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LoadingImplToJson(_$LoadingImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ErrorDetailsImpl _$$ErrorDetailsImplFromJson(Map<String, dynamic> json) =>
    _$ErrorDetailsImpl(
      json['message'] as String?,
      json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ErrorDetailsImplToJson(_$ErrorDetailsImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_$ComplexImpl _$$ComplexImplFromJson(Map<String, dynamic> json) =>
    _$ComplexImpl(
      json['a'] as int,
      json['b'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ComplexImplToJson(_$ComplexImpl instance) =>
    <String, dynamic>{
      'a': instance.a,
      'b': instance.b,
      'runtimeType': instance.$type,
    };
