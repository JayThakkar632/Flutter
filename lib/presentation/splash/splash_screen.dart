import 'dart:async';
import 'package:first_flutter_demo_app/presentation/check_internet_connectivity/bloc/internet_bloc.dart';
import 'package:first_flutter_demo_app/presentation/get_it/repository/locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared_preferences/shared_prefs_key.dart';
import '../home_screen//home_screen.dart';
import '../login/login_screen.dart';

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
    return Scaffold(
      body:locator.get<InternetBloc>().checkStatus(context),
      // body: Container(
      //   color: Colors.white,
      //   child: Image.asset('assets/images/logo.jpeg'),
      // ),
    );
  }
}

void navigateToScreen(BuildContext context) async {
  var pref = await SharedPreferences.getInstance();
  var isLogin = pref.getBool(SharedPreferencesKey.isLogin) ?? false;

  Future.delayed(const Duration(seconds: 5), (){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
            isLogin ? const HomeScreen() : const LoginScreen()));
  });
  // Timer(const Duration(seconds: 5), () {
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               isLogin ? const HomeScreen() : const LoginScreen()));
  // });
}
