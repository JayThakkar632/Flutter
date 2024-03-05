import 'package:flutter/material.dart';

import '../../Model/user_details.dart';
import '../../common_widget/appbar.dart';

class UserDetailsScreen extends StatelessWidget{
  final UserDetails userDetails;
  const UserDetailsScreen({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:appBar(title: "User Details", context: context),body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Id:${userDetails.id.toString()}"),
            const SizedBox(height: 15,),
            Text("Title:${userDetails.title.toString()}"),
            const SizedBox(height: 15,),
            Text("Description:${userDetails.body.toString()}"),
          ],
        ),
      ));
  }

}