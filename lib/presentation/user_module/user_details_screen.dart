import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:flutter/material.dart';
import '../../model/user_details.dart';

class UserDetailsScreen extends StatelessWidget{
  final UserDetails userDetails;
  const UserDetailsScreen({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return TopWidget(
      title: 'User Details',
        child: Padding(
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