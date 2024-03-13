import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../form/signup_form.dart';

class UserProfileScreen extends StatefulWidget{
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>{
  final _opacityOfImage = 1.0;
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
              child: const SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 200, left: 30),
                      child: Text(
                        "Edit\nAccount",
                        style: TextStyle(fontSize: 35, color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SignUpForm(isFromEditProfile: true,),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}