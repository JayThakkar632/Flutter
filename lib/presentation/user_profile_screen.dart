import 'package:flutter/cupertino.dart';

import 'form/signup_profile_screen.dart';

class UserProfileScreen extends StatefulWidget{
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SignUpProfileScreen('Edit Profile');
  }
}