import 'package:first_flutter_demo_app/pojo/UserModel.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';

import '../common_widget/appbar.dart';

class UserDetailsScreen extends StatelessWidget{
  final UserModel userModel;
  const UserDetailsScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:appBar(title: "User Details", context: context),body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Id:${userModel.id.toString()}"),
            const SizedBox(height: 15,),
            Text("Title:${userModel.title.toString()}"),
            const SizedBox(height: 15,),
            Text("Description:${userModel.body.toString()}"),
          ],
        ),
      ));
  }

}