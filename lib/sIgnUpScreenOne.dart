import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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
  var phoneNumberController = TextEditingController();
  var dateOfBirtController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  bool isValidateEmail=true;
  bool isValidatePassword=false;
  bool isValidateName=false;
  bool isValidatePhoneNumber=false;
  bool isValidateConfirmPassword=false;
  bool isValidateDateOfBirth=false;
  bool isValidateCountry=false;
  bool isValidateState=false;
  bool isValidateCity=false;
  var opacityOfImage=1.0;
  var selectedGender="";

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
                child: Image.asset('assets/images/leaf.png',height: 500,width: 300,fit: BoxFit.contain,)),
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
                child: Image.asset('assets/images/leaf.png',height: 500,width: 100,fit: BoxFit.contain,)),
          ),
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
                          labelText: 'Your email', errorText: !isValidateEmail ? "Please enter email" : null ,
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
                    const SizedBox(height:15),
                    TextField(
                      controller: phoneNumberController,
                      maxLines: 1,
                      cursorColor: Colors.green,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Phone Number', errorText: isValidatePhoneNumber ? "Please enter phone number":null ,
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
                    /*const SizedBox(height:15),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a gender';
                        }
                        return null;
                      },
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Select Gender',
                        labelText: 'Gender',
                      ),
                    ),*/
                    const SizedBox(height:15),
                    TextField(
                      controller: dateOfBirtController,
                      cursorColor: Colors.green,
                      canRequestFocus: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Date Of Birth', errorText: isValidateDateOfBirth ? "Please enter Date of Birth":null ,
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
                      controller: countryController,
                      cursorColor: Colors.green,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Country', errorText: isValidateCountry ? "Please enter Country":null ,
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
                      controller: stateController,
                      cursorColor: Colors.green,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'State', errorText: isValidateState ? "Please enter State":null ,
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
                      controller: cityController,
                      cursorColor: Colors.green,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'City', errorText: isValidateCity ? "Please enter City":null ,
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
                            nameController.text.isEmpty ? isValidateName = true : isValidateName = false;
                            phoneNumberController.text.isEmpty ? isValidatePhoneNumber = true : isValidatePhoneNumber = false;
                            isValidateEmail=EmailValidator.validate(emailController.text);
                            //emailController.text.isEmpty ? isValidateEmail = true : isValidateEmail = false;
                            passwordController.text.isEmpty ? isValidatePassword = true : isValidatePassword = false;
                            confirmPasswordController.text.isEmpty ? isValidateConfirmPassword = true : isValidateConfirmPassword = false;

                          });
                        }, 30)),

                    //DOB country state city, hobbies
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