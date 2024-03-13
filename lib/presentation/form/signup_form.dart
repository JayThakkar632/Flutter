import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:first_flutter_demo_app/common_widget/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widget/round_elevated_button.dart';
import '../../common_widget/snack_bar.dart';
import '../../shared_preferences/shared_prefs_key.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpFormKey {
  static const String name = "name";
  static const String email = "email";
  static const String psw = "psw";
  static const String cpsw = "cPsw";
  static const String phoneNumber = "phoneNumber";
  static const String dob = "dateOfBirth";
  static const String country = "country";
  static const String state = "state";
  static const String city = "city";
  static const String hobbies = "hobbies";
}

class SignUpForm extends StatefulWidget {
  final bool isFromEditProfile;

  const SignUpForm({this.isFromEditProfile = false, super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var _path = '';
  DateTime? _selectedDate;
  XFile? _image;
  final List<String> _hobby = [
    'Reading',
    'Cooking',
    'Playing',
    'Travelling',
    'Gaming'
  ];
  final List<dynamic> _selectedHobby = [];
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    widget.isFromEditProfile ? getDataFromPrefs() : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonTextFormFiled(
                    label: 'Name',
                    errorMessage: 'Please enter name',
                    name: SignUpFormKey.name,
                  ),
                  const SizedBox(height: 15),
                  FormBuilderTextField(
                      name: SignUpFormKey.email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      ])),
                  const SizedBox(height: 15),
                  FormBuilderTextField(
                      name: SignUpFormKey.psw,
                      obscureText: true,
                      cursorColor: Colors.green,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.grey)),
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.required(
                          errorText: "Please enter password")),
                  const SizedBox(height: 15),
                  FormBuilderTextField(
                      name: SignUpFormKey.cpsw,
                      obscureText: true,
                      cursorColor: Colors.green,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.grey)),
                      validator: FormBuilderValidators.required(
                          errorText: "Please enter confirm password")),
                  const SizedBox(height: 15),
                  FormBuilderTextField(
                    name: SignUpFormKey.phoneNumber,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        labelText: 'Phone number',
                        counterText: '',
                        labelStyle: TextStyle(color: Colors.grey)),
                    maxLines: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.green,
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(10),
                      FormBuilderValidators.maxLength(10),
                    ]),
                  ),
                  const SizedBox(height: 15),
                  FormBuilderTextField(
                      name: SignUpFormKey.dob,
                      readOnly: true,
                      onTap: () => selectDate(context),
                      cursorColor: Colors.green,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                          labelStyle: TextStyle(color: Colors.grey)),
                      validator: FormBuilderValidators.required(
                          errorText: "Please enter dateOfBirth")),
                  const SizedBox(height: 15),
                  CommonTextFormFiled(
                      label: 'Country',
                      errorMessage: 'Please enter country',
                      name: SignUpFormKey.country),
                  const SizedBox(height: 15),
                  CommonTextFormFiled(
                      label: 'State',
                      errorMessage: 'Please select state',
                      name: SignUpFormKey.state),
                  const SizedBox(height: 15),
                  CommonTextFormFiled(
                      label: 'City',
                      errorMessage: 'Please enter city',
                      name: SignUpFormKey.city),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      RoundedElevatedButton(
                        title: "Choose Your Profile Picture",
                        voidCallback: () {
                          imagePicker();
                        },
                      ),
                      const Spacer(),
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
                  FormBuilderCheckboxGroup(
                    name: SignUpFormKey.hobbies,
                    options: _hobby
                        .map((e) => FormBuilderFieldOption(
                              value: e,
                            ))
                        .toList(),
                    initialValue: _selectedHobby,
                    onChanged: (value) {
                      _selectedHobby.clear();
                      _selectedHobby.addAll(value!);
                    },
                  ),
                  const SizedBox(height: 45),
                  RoundedElevatedButton(
                    width: MediaQuery.sizeOf(context).width,
                    title: !widget.isFromEditProfile
                        ? "Sign Up"
                        : "Update Profile",
                    voidCallback: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        var prefs = await SharedPreferences.getInstance();
                        String encodedMap =
                            json.encode(_formKey.currentState?.value);
                        prefs.setString(
                            SharedPreferencesKey.signUpData, encodedMap);
                        prefs.setString(
                            SharedPreferencesKey.profileImage, _path);
                        showSnackBar(
                            !widget.isFromEditProfile
                                ? 'SignUp Successfully'
                                : 'Profile Updated Successfully',
                            context);
                        !widget.isFromEditProfile
                            ? Future.delayed(const Duration(seconds: 5), () {
                                Navigator.pop(context);
                              })
                            : null;
                      }
                    },
                    radius: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
      ),
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
        _selectedDate = datePicker;
        _selectedDate == null
            ? ''
            : _formKey.currentState?.fields['dateOfBirth']
                ?.didChange(DateFormat('dd/MM/yyyy').format(_selectedDate!));
        //DateFormat('dd/MM/yyyy').format(_selectedDate!)
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

  void getDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final sharedPrefData = prefs.getString(SharedPreferencesKey.signUpData) ?? "";
    List<dynamic> list = [];
    if (sharedPrefData.isNotEmpty) {
      setState(() {
        final Map<String, dynamic> data = jsonDecode(sharedPrefData);
        _formKey.currentState?.patchValue(data);
        _path = prefs.getString(SharedPreferencesKey.profileImage) ?? "";
        data.forEach((key, value) {
          if (key == SignUpFormKey.hobbies) {
            list.add(value);
          }
        });
      });
      if (list.isNotEmpty) {
        for (var value in list) {
          _selectedHobby.add(value.toString().trim());
        }
      }
    }
  }
}
