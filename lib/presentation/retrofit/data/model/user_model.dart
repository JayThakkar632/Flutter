import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel{
    int userId;
    int id;
    String title;
    String body;

    UserModel(this.userId,this.id,this.title,this.body);

    factory UserModel.fromJson(Map<String,dynamic> json)=> _$UserModelFromJson(json);
    Map<String,dynamic>toJson()=> _$UserModelToJson(this);

}
