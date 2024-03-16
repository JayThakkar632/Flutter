import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel{
  final int id;
  final String name;

  UserModel(this.id,this.name);
  factory UserModel.fromJson(Map<String,dynamic> json)=> _$UserModelFromJson(json);
  Map<String,dynamic>toJson() => _$UserModelToJson(this);
}
