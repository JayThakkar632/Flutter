import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_freezed_model.freezed.dart';
part 'user_freezed_model.g.dart';

@freezed
class UserFreezedModel with _$UserFreezedModel{
  const factory UserFreezedModel(String id,String name) = _UserFreezedModel;
  factory UserFreezedModel.fromJson(Map<String,dynamic> json) => _$UserFreezedModelFromJson(json);
}

@freezed
class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = ErrorDetails;
  const factory Union.complex(int a, String b) = Complex;

  factory Union.fromJson(Map<String, Object?> json) => _$UnionFromJson(json);
}