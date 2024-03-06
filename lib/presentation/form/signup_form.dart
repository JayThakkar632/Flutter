import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:first_flutter_demo_app/Model/shared_preferences.dart';
import 'package:first_flutter_demo_app/common_widget/text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widget/round_elevated_button.dart';
import '../../common_widget/snack_bar.dart';
import '../../shared_preferences/shared_prefs_key.dart';

class SignUpProfileScreen extends StatefulWidget {
  var _title = '';

  SignUpProfileScreen(this._title, {super.key});

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dateOfBirtController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  var _opacityOfImage = 1.0;
  var _path = '';
  DateTime? _selectedDate;
  XFile? _image;
  Map<String, bool> _hobby = {
    'Reading': false,
    'Cooking': false,
    'Playing': false,
    'Travelling': false,
    'Gaming': false
  };
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget._title != 'Create\nAccount' ? getDataFromPrefs() : null;
  }

  @override
  Widget build(BuildContext context) {
    var _title = widget._title;
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        visible ? _opacityOfImage = 0.5 : _opacityOfImage = 1.0;
      });
    });
    return Scaffold(
      body:  NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              setState(() {
                _opacityOfImage = 0.5;
              });
            } else if (notification is ScrollEndNotification) {
              setState(() {
                _opacityOfImage = 1.0;
              });
            }
            return true;
          },
      child: Stack(
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
          Container(
            height: MediaQuery
                .sizeOf(context)
                .height,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Text(_title,
                        style: TextStyle(fontSize: 35, color: Colors.green),),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonTextFormFiled(controller: _nameController,label: 'Name',errorMessage:'Please enter name',),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _emailController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: 'Email', labelStyle: TextStyle(
                                color: Colors.grey)),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s'))
                            ],
                            maxLines: 1,
                            cursorColor: Colors.green,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              } else if (!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                  .hasMatch(value)) {
                                return 'Please enter valid email';
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            cursorColor: Colors.green,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                labelText: 'Password', labelStyle: TextStyle(
                                color: Colors.grey)),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter password'
                                  : null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            cursorColor: Colors.green,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(color: Colors.grey)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else if (value != _passwordController.text) {
                                return 'Password mismatch';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _phoneNumberController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(labelText: 'Phone number',counterText: '',labelStyle: TextStyle(color: Colors.grey)),
                            maxLines: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\.'))
                            ],
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.green,
                            textInputAction: TextInputAction.next,
                            maxLength: 10,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please enter phoneNumber';
                              }else if(value.length !=10){
                                return 'Please enter valid phone Number';
                              }else{
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            readOnly: true,
                            onTap: () {
                              selectDate(context);
                            },
                            controller: _dateOfBirtController,
                            cursorColor: Colors.green,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Date of Birth', labelStyle: TextStyle(
                                color: Colors.grey)),
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter date of birth'
                                  : null;
                            },
                          ),
                          const SizedBox(height: 15),
                          CommonTextFormFiled(controller: _countryController,label: 'Country',errorMessage:'Please enter country'),
                          const SizedBox(height: 15),
                          CommonTextFormFiled(controller: _stateController,label: 'State',errorMessage:'Please select state'),
                          const SizedBox(height: 15),
                          CommonTextFormFiled(controller: _cityController,label: 'City',errorMessage:'Please enter city'),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              RoundedElevatedButton(
                                title: "Choose Your Profile Picture", voidCallback: () {
                                imagePicker();
                              },),
                              Spacer(),
                              _path.isNotEmpty
                                  ? CircleAvatar(
                                backgroundImage: FileImage(File(_path)),
                              )
                                  : const SizedBox(),
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
                            children: List.generate(_hobby.length, (index) {
                              final key = _hobby.keys.elementAt(index);
                              final value = _hobby[key] ??
                                  false; // Use false as default if key not found
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: value,
                                    activeColor: Colors.green,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _hobby[key] = newValue ?? false;
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
                              width: MediaQuery
                                  .sizeOf(context)
                                  .width,
                              child: RoundedElevatedButton(
                                title: _title == 'Create\nAccount'
                                    ? "Sign Up"
                                    : "Update Profile", voidCallback: () async {
                                if (_formKey.currentState!.validate()) {
                                  var prefs = await SharedPreferences.getInstance();
                                  var sharedPreferences = SharedPreferencesModel(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      confirmPassword: _confirmPasswordController.text,
                                      phoneNumber: _phoneNumberController.text,
                                      dob: _dateOfBirtController.text,
                                      country: _countryController.text,
                                      state: _stateController.text,
                                      city: _cityController.text,
                                      profile: _path,
                                      hobby: _hobby);
                                  await prefs.setString(SharedPreferencesKey.userModel,
                                      jsonEncode(sharedPreferences.toJson()));
                                  showSnackBar(_title == 'Create\nAccount'
                                      ? 'SignUp Successfully'
                                      : 'Profile Updated Successfully', context);
                                  _title == 'Create\nAccount' ? Timer(const Duration(
                                      seconds: 5), () {
                                    Navigator.pop(context);
                                  }) : null;
                                }
                              }, radius: 30,)),
                          //DOB country state city, hobbies
                          const SizedBox(
                            height: 30,
                          ),
                          _title == 'Create\nAccount' ? Padding(
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
                          ) : SizedBox(),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime(2050),
        initialDate: DateTime.now());
    if (datePicker != null) {
      setState(() {
        _selectedDate = datePicker;
        _dateOfBirtController.text = (_selectedDate == null)
            ? ''
            : DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }


  Future<void> imagePicker() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;

      _path = _image!.path ?? "";
    });
  }

  Future<SharedPreferencesModel?> getDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final sharedPrefData = prefs.getString(SharedPreferencesKey.userModel);
    if (sharedPrefData != null) {
      setState(() {
        final Map<String, dynamic> data = jsonDecode(sharedPrefData);
        var sharedPreferencesModel = SharedPreferencesModel.fromJson(data);
        _nameController.text = sharedPreferencesModel.name!;
        _emailController.text = sharedPreferencesModel.email!;
        _passwordController.text = sharedPreferencesModel.password!;
        _confirmPasswordController.text = sharedPreferencesModel.confirmPassword!;
        _phoneNumberController.text = sharedPreferencesModel.phoneNumber!;
        _dateOfBirtController.text = sharedPreferencesModel.dob!;
        _countryController.text = sharedPreferencesModel.country!;
        _stateController.text = sharedPreferencesModel.state!;
        _cityController.text = sharedPreferencesModel.city!;
        _path = sharedPreferencesModel.profile ?? "";
        _hobby = sharedPreferencesModel.hobby ?? <String, bool>{};
      });

    }
  }

}



