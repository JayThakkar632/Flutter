import 'package:first_flutter_demo_app/signInScreen.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height*0.7,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40)),
              color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.arrow_back_ios_sharp),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Sign up",textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(left: 0,top: 20,right: 8),
                child: Row(
                  children: [
                    Expanded(child:
                    Icon(Icons.arrow_back_ios_sharp)),
                    Spacer(),
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Spacer(flex: 2,)
                  ],
                ),
              ),*/
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, top: 30),
                child: TextField(
                  controller: fullNameController,
                  decoration: editText('Full Name', 50,_validate),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, top: 30),
                child: TextField(
                    controller: phoneNumberController,
                    maxLines: 1,
                    decoration: editText('Phone Number', 50,false),
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, top: 30),
                child: TextField(
                  controller: emailController,
                  maxLines: 1,
                  decoration: editText('Email ID', 50,false),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: TextField(
                  controller: passController,
                  maxLines: 1,
                  decoration: editText('Password', 50,false),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Container(
                    width: double.infinity,
                    height: 60,
                    child: roundedElevatedButton(
                        'CREATE ACCOUNT', Colors.black, () async {
                          String fullName=emailController.text.toString();
                          if(fullName.isEmpty){
                            setState(() {
                              _validate = true;
                            });
                          }else{
                            _validate=false;
                            var pref=await SharedPreferences.getInstance();
                            pref.setString("emailId", emailController.text.toString());
                            pref.setString("password", passController.text.toString());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                          }

                    },50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
