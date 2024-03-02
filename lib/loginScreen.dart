import 'package:first_flutter_demo_app/sIgnUpScreenOne.dart';
import 'package:first_flutter_demo_app/signUpScreen.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                alignment: Alignment.bottomLeft,
                image: AssetImage('assets/images/leaf.png'),
              )),
              child: Login()),
        ],
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isValidateEmail = true;
  bool isValidatePassword = false;
  var opacityOfImage=1.0;

  @override
  Widget build(BuildContext context) {
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        visible ? opacityOfImage=0.5 : opacityOfImage=1.0;
      });
    });
    return Stack(
      children: [
        Positioned(
          right: -100,
          top: -150,
          child: Opacity(
            opacity: opacityOfImage,
            child: Transform(
                transform: Matrix4.rotationZ(0.8),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/leaf.png',
                  height: 500,
                  width: 300,
                  fit: BoxFit.contain,
                )),
          ),
        ),
        Positioned(
          right: -60,
          top: 0,
          child: Opacity(
            opacity: opacityOfImage,
            child: Transform(
                transform: Matrix4.rotationZ(1.5),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/leaf.png',
                  height: 500,
                  width: 100,
                  fit: BoxFit.contain,
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome\nBack",
                      style: TextStyle(fontSize: 35, color: Colors.green),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      cursorColor: Colors.green,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          errorText:
                              !isValidateEmail ? "Please enter email" : null,
                          labelStyle: const TextStyle(
                            color: Colors.grey, //<-- SEE HERE
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      cursorColor: Colors.green,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'Password',
                        errorText:
                            isValidatePassword ? "Please enter password" : null,
                        labelStyle: const TextStyle(
                          color: Colors.grey, //<-- SEE HERE
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        suffix: GestureDetector(
                          onTap: () {},
                          child: Text("Forgot?",
                              style: TextStyle(color: Colors.green)),
                        ),
                        //suffix: Text("Forgot?",style: TextStyle(color: Colors.green),)
                      ),
                    ),
                    const SizedBox(height: 45),
                    SizedBox(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width,
                        child: roundedElevatedButton("Sign in", Colors.green,
                            () async {
                          var pref = await SharedPreferences.getInstance();
                          var getEmail = pref.getString(email);
                          var getPassword = pref.getString(password);
                          setState(() {
                            isValidateEmail =
                                EmailValidator.validate(emailController.text);
                            //print('$isValidateEmail');
                            //emailController.text.isEmpty ? isValidateEmail = true : isValidateEmail = false;
                            passwordController.text.isEmpty
                                ? isValidatePassword = true
                                : isValidatePassword = false;
                          });
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            if (emailController.text.toString() == getEmail &&
                                passwordController.text.toString() ==
                                    getPassword) {
                              pref.setBool(login, true);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            } else {
                              showSnackBar("Invalid credentials");
                            }
                          }
                        }, 30)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                        child: Text(
                      'or',
                      style: TextStyle(color: Colors.grey),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width,
                        child: roundedOutLinedButtonOne("Sign in with Google",
                            Colors.white12, () {}, Colors.green)),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: RichText(
                            text: TextSpan(
                                text: "Create account?",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign up',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpScreenOne()));
                                    })
                            ])),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void showSnackBar(String msg) {
    var snackBar = SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
