import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SignUpScreenOne extends StatefulWidget{
  @override
  State<SignUpScreenOne> createState() => _SignupScreenOneState();
}

class _SignupScreenOneState extends State<SignUpScreenOne> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body:SignUp()
    );
  }
}

class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

const  name='name';
const  email='email';
const  password='password';
const  confirmPassword='confirmPassword';
const  login='isLogin';

class _SignUpState extends State<SignUp> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  bool isValidateEmail=false;
  bool isValidatePassword=false;
  bool isValidateName=false;
  bool isValidateConfirmPassword=false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -100,
          top: -150,
          child: Transform(
              transform: Matrix4.rotationZ(0.8),
              alignment: Alignment.center,
              child: Image.asset('assets/images/leaf.png',height: 500,width: 300,fit: BoxFit.contain,)),
        ),
        Positioned(
          right: -60,
          top: 0,
          child: Transform(
              transform: Matrix4.rotationZ(1.5),
              alignment: Alignment.center,
              child: Image.asset('assets/images/leaf.png',height: 500,width: 100,fit: BoxFit.contain,)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.sizeOf(context).height*0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 30,top: 10,right: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Create\nAccount",style: TextStyle(fontSize: 35,color: Colors.green),),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: nameController,
                      maxLines: 1,
                      cursorColor: Colors.green,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Your name', errorText: isValidateName ? "Please enter name":null ,
                          labelStyle: const TextStyle(
                            color: Colors.grey, //<-- SEE HERE
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green
                              )
                          )
                      ),
                    ),
                    const SizedBox(height:15),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      cursorColor: Colors.green,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Your email', errorText: isValidateEmail ? "Please enter email" : null ,
                          labelStyle: const TextStyle(
                            color: Colors.grey, //<-- SEE HERE
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green
                              )
                          )
                      ),
                    ),
                    const SizedBox(height:15),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      cursorColor: Colors.green,
                      textInputAction: TextInputAction.done,
                      decoration:  InputDecoration(
                          labelText: 'Password',
                          errorText: isValidatePassword ? "Please enter password" : null,
                          labelStyle: const TextStyle(
                            color: Colors.grey, //<-- SEE HERE
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green
                              )
                          ),
                          //suffix: Text("Forgot?",style: TextStyle(color: Colors.green),)
                      ),
                    ),
                    const SizedBox(height:15),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      cursorColor: Colors.green,
                      textInputAction: TextInputAction.done,
                      decoration:  InputDecoration(
                          labelText: 'Confirm password',
                          errorText: isValidateConfirmPassword ? "Please enter confirm password" : null,
                          labelStyle: const TextStyle(
                            color: Colors.grey, //<-- SEE HERE
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green
                              )
                          ),
                          //suffix: Text("Forgot?",style: TextStyle(color: Colors.green),)
                      ),
                    ),
                    const SizedBox(height:45),
                    SizedBox(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width,
                        child: roundedElevatedButton("Sign Up", Colors.green, () async {
                          if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty){
                            if(passwordController.text.toString() == confirmPasswordController.text.toString()){
                              var pref=await SharedPreferences.getInstance();
                              pref.setString(email, emailController.text.toString());
                              pref.setString(password, passwordController.text.toString());
                              Navigator.pop(context);
                            }else{
                              showSnackBar("Password mismatch");
                            }
                          }
                          setState(() {
                            //isValidateEmail=EmailValidator.validate(emailController.text);
                            nameController.text.isEmpty ? isValidateName = true : isValidateName = false;
                            emailController.text.isEmpty ? isValidateEmail = true : isValidateEmail = false;
                            passwordController.text.isEmpty ? isValidatePassword = true : isValidatePassword = false;
                            confirmPasswordController.text.isEmpty ? isValidateConfirmPassword = true : isValidateConfirmPassword = false;

                          });
                        }, 30)),
                    const SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: RichText(text: TextSpan(
                            text: "Back to",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(text: ' Sign in',
                                  style: TextStyle(color: Colors.green, fontSize: 14,fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pop(context);
                                    }
                              )
                            ]
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        /*Align(
          alignment: Alignment.bottomLeft,
          child: Positioned(
            bottom: 0,
            left: 0,
            child: Transform(
                transform: Matrix4.rotationZ(3.5),
                alignment: Alignment.center,
                child: Image.asset('assets/images/leaf.png')),
          ),
        ),*/
      ],
    );
  }
  void showSnackBar(String msg){
    var snackBar= SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: 'OK',
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}