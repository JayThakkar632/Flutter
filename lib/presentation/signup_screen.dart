import 'dart:async';
import 'dart:io';
import 'package:first_flutter_demo_app/presentation/form/signup_profile_screen.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../common_widget/snack_bar.dart';
import '../constant/const_key.dart';

class SignUpScreenOne extends StatefulWidget {
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
    return SignUpProfileScreen('Create Account');
  }

}
