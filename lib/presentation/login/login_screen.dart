import 'dart:convert';

import 'package:first_flutter_demo_app/presentation/signup/signup_screen.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../Model/shared_preferences.dart';
import '../../common_widget/snack_bar.dart';
import '../../shared_preferences/shared_prefs_key.dart';
import '../main.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Login()
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
  var _opacityOfImage=1.0;
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        visible ? _opacityOfImage=0.5 : _opacityOfImage=1.0;
      });
    });
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
        Container(
          height: MediaQuery.sizeOf(context).height,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: Text(
                      "Welcome\nBack",
                      style: TextStyle(fontSize: 35, color: Colors.green),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(labelText: 'Email',labelStyle: TextStyle(color: Colors.grey)),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s'))
                          ],
                          maxLines: 1,
                          cursorColor: Colors.green,
                          textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email()
                            ]), name: 'email',
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          obscureText: true,
                          cursorColor: Colors.green,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(labelText: 'Password',labelStyle: TextStyle(color: Colors.grey)),
                          textInputAction: TextInputAction.next,
                          validator: FormBuilderValidators.required(
                              errorText: "Please enter password"), name: 'password',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 45),
                  SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width,
                      child: roundedElevatedButton("Sign in", Colors.green,
                          () async {
                           if(_formKey.currentState!.saveAndValidate()){
                             final prefs = await SharedPreferences.getInstance();
                             final sharedPrefData = prefs.getString(SharedPreferencesKey.userModel);
                             var getEmail='';
                             var getPassword='';
                             var pref = await SharedPreferences.getInstance();
                             if(sharedPrefData!=null){
                               final Map<String, dynamic> data = jsonDecode(sharedPrefData);
                               var sharedPreferencesModel =  SharedPreferencesModel.fromJson(data);
                               getEmail =sharedPreferencesModel.email!;
                               getPassword = sharedPreferencesModel.password!;
                             }
                             if(_formKey.currentState?.value['email'] == getEmail &&
                                 _formKey.currentState?.value['password']  ==
                                     getPassword) {
                               pref.setBool(SharedPreferencesKey.isLogin, true);
                               Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => MyHomePage()));
                             }else{
                               showSnackBar("Please provide valid credentials", context);
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
        )
      ],
    );
  }


}
