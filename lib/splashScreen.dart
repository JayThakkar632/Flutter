import 'dart:async';
import 'package:first_flutter_demo_app/main.dart';
import 'package:first_flutter_demo_app/startScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'signInScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState()  {
    navigate(context);
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

void navigate(BuildContext context) async{
  var pref= await SharedPreferences.getInstance();
  var isLogin=pref.getBool("isLogin");
  if(isLogin != null){
    if(isLogin){
      Timer(const Duration(seconds: 5),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
      });
    }else{
      Timer(const Duration(seconds: 5),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const StartScreen()));
      });
    }
  }else{
    Timer(const Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const StartScreen()));
    });
  }


}
