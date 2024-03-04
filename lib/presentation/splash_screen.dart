import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/const_key.dart';
import 'login_screen.dart';
import 'main.dart';
import 'old_program/signInScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset('assets/images/logo.jpeg'),
    );
  }
}

void navigateToScreen(BuildContext context) async {
  var pref = await SharedPreferences.getInstance();
  var isLogin = pref.getBool(Constants.IS_LOGIN) ?? false;
  Timer(const Duration(seconds: 5), () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                isLogin ? const MyHomePage() : const LoginScreen()));
  });
}
