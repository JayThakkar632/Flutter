import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:first_flutter_demo_app/Model/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widget/round_elevated_button.dart';
import '../../common_widget/snack_bar.dart';
import '../../constant/const_key.dart';

class SignUpProfileScreen extends StatefulWidget {
   var title='';
   SignUpProfileScreen(this.title, {super.key});

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var dateOfBirtController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  bool isValidatePhoneNumber = true;
  bool isValidateEmail = true;
  var opacityOfImage = 1.0;
  var errorMsg = null;
  var emailErrorMsg = null;
  var path='';
  final phoneNumberValidator = RegExp(r'^[0-9]{10}$');
  DateTime? selectedDate;
  XFile? image;
  Map<String, bool> hobby = {
    'Reading': false,
    'Cooking': false,
    'Playing': false,
    'Travelling': false,
    'Gaming': false
  };

  @override
  void initState() {
    super.initState();
    getDataFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.title);
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        visible ? opacityOfImage = 0.5 : opacityOfImage = 1.0;
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
                      "Create\nAccount",
                      style: TextStyle(fontSize: 35, color: Colors.green),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: nameController,
                    maxLines: 1,
                    cursorColor: Colors.green,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Your name',
                        errorText: nameController.text.isEmpty
                            ? 'Please enter name'
                            : null,
                        labelStyle: const TextStyle(
                          color: Colors.grey, //<-- SEE HERE
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ],
                    maxLines: 1,
                    cursorColor: Colors.green,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Your email',
                        errorText: emailErrorMsg,
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
                      labelText: 'Password',
                      errorText: passwordController.text.isEmpty
                          ? 'Please enter password'
                          : null,
                      labelStyle: const TextStyle(
                        color: Colors.grey, //<-- SEE HERE
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      //suffix: Text("Forgot?",style: TextStyle(color: Colors.green),)
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    cursorColor: Colors.green,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      errorText: passwordController.text.isEmpty
                          ? 'Please enter confirm password'
                          : null,
                      labelStyle: const TextStyle(
                        color: Colors.grey, //<-- SEE HERE
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      //suffix: Text("Forgot?",style: TextStyle(color: Colors.green),)
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: phoneNumberController,
                    maxLines: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\.'))
                    ],
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.green,
                    textInputAction: TextInputAction.next,
                    maxLength: 10,
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        counterText: '',
                        errorText: errorMsg,
                        labelStyle: const TextStyle(
                          color: Colors.grey, //<-- SEE HERE
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  const SizedBox(height: 15),
                  /*DropdownButton(
                    hint: const Text('Gender'),
                      value: selectedGender,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });

                      },items: gender.map((gender) {
                    return DropdownMenuItem(
                      child: Text(gender),
                      value: gender,
                    );
                  }).toList(),),*/
                  const SizedBox(height: 15),
                  TextField(
                    readOnly: true,
                    onTap: () {
                      selectDate(context);
                    },
                    controller: dateOfBirtController,
                    cursorColor: Colors.green,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Date Of Birth',
                        errorText: dateOfBirtController.text.isEmpty
                            ? 'Please enter Date of Birth'
                            : null,
                        labelStyle: const TextStyle(
                          color: Colors.grey, //<-- SEE HERE
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: countryController,
                    cursorColor: Colors.green,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Country',
                        errorText: countryController.text.isEmpty
                            ? 'Please enter Country'
                            : null,
                        labelStyle: const TextStyle(
                          color: Colors.grey, //<-- SEE HERE
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: stateController,
                    cursorColor: Colors.green,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'State',
                        errorText: stateController.text.isEmpty
                            ? 'Please enter State'
                            : null,
                        labelStyle: const TextStyle(
                          color: Colors.grey, //<-- SEE HERE
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: cityController,
                    cursorColor: Colors.green,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'City',
                        errorText: cityController.text.isEmpty
                            ? 'Please enter City'
                            : null,
                        labelStyle: const TextStyle(
                          color: Colors.grey, //<-- SEE HERE
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      roundedElevatedButton(
                          "Choose Your Profile Picture", Colors.green, () {
                        imagePicker();
                      }, 20),
                      Spacer(),
                      image != null
                          ? CircleAvatar(
                              backgroundImage: FileImage(File(image!.path)),
                            )
                          : const Text(''),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                      child: Text(
                    'Select Your Hobbies',
                    style: TextStyle(color: Colors.grey),
                  )),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: List.generate(hobby.length, (index) {
                      final key = hobby.keys.elementAt(index);
                      final value = hobby[key] ?? false; // Use false as default if key not found
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: value,
                            activeColor: Colors.green,
                            onChanged: (newValue) {
                              setState(() {
                                hobby[key] = newValue ?? false;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          Text(key),
                        ],
                      );
                    }),
                  )
                  ,
                  const SizedBox(height: 45),
                  SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width,
                      child: roundedElevatedButton(
                          "Sign Up", Colors.green, () async {
                            if(nameController.text.isNotEmpty &&
                                isValidateEmail &&
                                passwordController.text.isNotEmpty &&
                                confirmPasswordController.text.isNotEmpty &&
                                isValidatePhoneNumber &&
                                dateOfBirtController.text.isNotEmpty &&
                                countryController.text.isNotEmpty &&
                                stateController.text.isNotEmpty &&
                                cityController.text.isNotEmpty){
                              if (passwordController.text.toString() ==
                                  confirmPasswordController.text.toString()) {
                                var prefs = await SharedPreferences.getInstance();
                                var sharedPreferences= SharedPreferencesModel(name: nameController.text,email:emailController.text,password: passwordController.text,confirmPassword: confirmPasswordController.text,phoneNumber: phoneNumberController.text,dob: dateOfBirtController.text,country: countryController.text,state: stateController.text,city: cityController.text,profile: path);
                                 await prefs.setString(Constants.USER_MODEL, jsonEncode(sharedPreferences.toJson()));
                                showSnackBar("SignUp Successfully",context);
                                Timer(const Duration(seconds: 5),(){
                                  Navigator.pop(context);
                                });
                              } else {
                                showSnackBar("Password mismatch",context);
                              }
                            }
                      }, 30)),

                  //DOB country state city, hobbies
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                              text: "Back to",
                              style:
                                  const TextStyle(color: Colors.grey, fontSize: 14),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime(2050),
        initialDate: DateTime.now());
    if (datePicker != null) {
      setState(() {
        selectedDate = datePicker;
        dateOfBirtController.text = (selectedDate == null)
            ? ''
            : DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }

  String? validatePhoneNumber() {
    if (phoneNumberController.text.isEmpty) {
      errorMsg = 'Please enter phone number';
    } else if (!phoneNumberValidator.hasMatch(phoneNumberController.text)) {
      errorMsg = 'Please enter valid phone number';
    } else {
      isValidateEmail = true;
      errorMsg = null;
    }
    return errorMsg;
  }

  String? validateEmailId() {
    if (emailController.text.isEmpty) {
      emailErrorMsg = 'Please enter email';
    } else if (EmailValidator.validate(emailController.text) == false) {
      emailErrorMsg = 'Please enter valid email address';
    } else {
      isValidatePhoneNumber = true;
      emailErrorMsg = null;
    }
    return emailErrorMsg;
  }

  Future<void> imagePicker() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage;
    });
  }

  Future<SharedPreferencesModel?> getDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final sharedPrefData = prefs.getString(Constants.USER_MODEL);
    if (sharedPrefData != null) {
      final Map<String, dynamic> data = jsonDecode(sharedPrefData);
      var sharedPreferencesModel =  SharedPreferencesModel.fromJson(data);
      nameController.text = sharedPreferencesModel.name!;
      emailController.text = sharedPreferencesModel.email!;
      passwordController.text = sharedPreferencesModel.password!;
      confirmPasswordController.text = sharedPreferencesModel.confirmPassword!;
      phoneNumberController.text = sharedPreferencesModel.phoneNumber!;
      dateOfBirtController.text = sharedPreferencesModel.dob!;
      countryController.text = sharedPreferencesModel.country!;
      stateController.text = sharedPreferencesModel.state!;
      cityController.text = sharedPreferencesModel.city!;
      path = sharedPreferencesModel.profile??"";
    }
  }
}



