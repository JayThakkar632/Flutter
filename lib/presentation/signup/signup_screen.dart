import 'package:first_flutter_demo_app/presentation/form/signup_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpScreenOne extends StatefulWidget {
  const SignUpScreenOne({super.key});

  @override
  State<SignUpScreenOne> createState() => _SignupScreenOneState();
}

class _SignupScreenOneState extends State<SignUpScreenOne> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: null, body: SignUp());
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    return SignUpProfileScreen('Create\nAccount');
  }

}
