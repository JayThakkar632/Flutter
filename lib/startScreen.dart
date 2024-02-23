import 'package:first_flutter_demo_app/signInScreen.dart';
import 'package:first_flutter_demo_app/signUpScreen.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height*0.7,
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),color: Colors.white),
          child:Column(
              children: [
                SizedBox(height: 90,),
                Text('Welcome to Car\n Wash Services',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                SizedBox(height: 90,),
                Padding(
                  padding: const EdgeInsets.only(left: 18,right: 18),
                  child: Container(
                    width: double.infinity,
                      height: 60,
                      child: roundedElevatedButton('SIGN UP',Colors.black,(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      })),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 18,right: 18),
                  child: Container(
                      width: double.infinity,
                      height: 60,
                      child: roundedOutLinedButton('LOGIN',Colors.white,(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                      })),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
