import 'package:first_flutter_demo_app/presentation/form/signup_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpScreenOne extends StatefulWidget {
  const SignUpScreenOne({super.key});

  @override
  State<SignUpScreenOne> createState() => _SignupScreenOneState();
}

class _SignupScreenOneState extends State<SignUpScreenOne> {
  var _opacityOfImage = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
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
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 200, left: 30),
                      child: Text(
                        "Create\nAccount",
                        style: TextStyle(fontSize: 35, color: Colors.green),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SignUpForm(),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: RichText(
                            text: TextSpan(
                                text: "Back to",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                                children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign in',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pop(context);
                                    })
                            ])),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
