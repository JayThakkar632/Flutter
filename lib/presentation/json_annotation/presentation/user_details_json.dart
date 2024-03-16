import 'dart:convert';

import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:first_flutter_demo_app/presentation/json_annotation/model/user_model.dart';
import 'package:flutter/material.dart';

class UserDetailsWithJson extends StatefulWidget {
  const UserDetailsWithJson({super.key});

  @override
  State<UserDetailsWithJson> createState() => _UserDetailsWithJsonState();
}

class _UserDetailsWithJsonState extends State<UserDetailsWithJson> {

  UserModel userModel =UserModel(1,"Jay");


  String  userModelJson ='{"id":1,"name":"Jay"}';

  @override
  Widget build(BuildContext context) {
    return TopWidget(title: 'Json Serializable', child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            var userMap=userModel.toJson();
            var json=jsonEncode(userMap);
            print(json);


          }, child: const Text("Serialization")),
          ElevatedButton(onPressed: (){
            var decode=jsonDecode(userModelJson);
            var user=UserModel.fromJson(decode);
            print(user);
          }, child: const Text("Deserialization")),
        ],
      ),
    ));
  }
}
