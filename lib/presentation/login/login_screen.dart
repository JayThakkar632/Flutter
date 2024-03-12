import 'dart:convert';
import 'package:first_flutter_demo_app/presentation/signup/signup_screen.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widget/round_elevated_button.dart';
import '../../common_widget/snack_bar.dart';
import '../../shared_preferences/shared_prefs_key.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../home_screen//home_screen.dart';

class LoginFormKey {
  static const String email = "email";
  static const String psw = "psw";
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _opacityOfImage = 1.0;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -100,
          top: -150,
          child: Opacity(
            opacity: _opacityOfImage,
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
            opacity: _opacityOfImage,
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
        Positioned(
          bottom: -100,
          left: -50,
          child: Transform(
              transform: Matrix4.rotationZ(-15),
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/leaf.png',
                ),
              )),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 200, left: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome\nBack",
                      style: TextStyle(fontSize: 35, color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  color: Colors.white30,
                  child: FormBuilder(
                    key: _formKey,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FormBuilderTextField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.grey)),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s'))
                            ],
                            maxLines: 1,
                            cursorColor: Colors.green,
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email()
                            ]),
                            name: LoginFormKey.email,
                          ),
                          const SizedBox(height: 15),
                          FormBuilderTextField(
                            obscureText: true,
                            cursorColor: Colors.green,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.grey)),
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.required(
                                errorText: "Please enter password"),
                            name: LoginFormKey.psw,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width,
                      child: RoundedElevatedButton(
                          title: "Sign in",
                          color: Colors.green,
                          voidCallback: () async {
                            if (_formKey.currentState!.saveAndValidate()) {
                              final prefs = await SharedPreferences.getInstance();
                              var sharedPrefData = prefs.getString(SharedPreferencesKey.signUpData) ?? "";
                              final Map<String, dynamic> data = jsonDecode(sharedPrefData);
                              var getEmail="";
                              var getPassword="";
                              data.forEach((key, value) {
                                if(key == LoginFormKey.email){
                                  getEmail=value;
                                }
                                if(key == LoginFormKey.psw){
                                  getPassword=value;
                                }
                              });
                              if (_formKey.currentState
                                          ?.value[LoginFormKey.email] ==
                                      getEmail &&
                                  _formKey.currentState
                                          ?.value[LoginFormKey.psw] ==
                                      getPassword) {
                                prefs.setBool(
                                    SharedPreferencesKey.isLogin, true);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              } else {
                                showSnackBar("Please provide valid credentials",
                                    context);
                              }
                            }
                          },
                          radius: 30)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'or',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width,
                      child: RoundedOutlineButton(
                          title: "Sign in with Google",
                          color: Colors.white12,
                          voidCallback: () {})),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Create account?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 5),
                        ),
                        TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
