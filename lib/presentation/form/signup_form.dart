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
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpProfileScreen extends StatefulWidget {
  var _title = '';

  SignUpProfileScreen(this._title, {super.key});

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
  var _opacityOfImage = 1.0;
  var _path = '';
  DateTime? _selectedDate;
  XFile? _image;
  List<String> _hobby = ['Reading','Cooking','Playing','Travelling','Gaming'];
  List<String> _selectedHobby = [];
  final _formKey = GlobalKey<FormBuilderState>();

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
        body: NotificationListener<ScrollNotification>(
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
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Text(
                        _title,
                        style: TextStyle(fontSize: 35, color: Colors.green),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonTextFormFiled(
                            label: 'Name',
                            errorMessage: 'Please enter name',
                            name: 'name',
                          ),
                          const SizedBox(height: 15),
                          FormBuilderTextField(
                              name: 'email',
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              name: 'password',
                              obscureText: true,
                              cursorColor: Colors.green,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.grey)),
                              textInputAction: TextInputAction.next,
                              validator: FormBuilderValidators.required(
                                  errorText: "Please enter password")),
                          const SizedBox(height: 15),
                          FormBuilderTextField(
                              name: 'confirmPassword',
                              obscureText: true,
                              cursorColor: Colors.green,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(color: Colors.grey)),
                              validator: FormBuilderValidators.required(
                                  errorText: "Please enter confirm password")
                              ),
                          const SizedBox(height: 15),
                          FormBuilderTextField(
                            name: 'phoneNumber',
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                labelText: 'Phone number',
                                counterText: '',
                                labelStyle: TextStyle(color: Colors.grey)),
                            maxLines: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\.'))
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
                              name: 'dateOfBirth',
                              readOnly: true,
                              onTap: () => selectDate(context),
                              cursorColor: Colors.green,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              name: 'country'),
                          const SizedBox(height: 15),
                          CommonTextFormFiled(
                              label: 'State',
                              errorMessage: 'Please select state',
                              name: 'state'),
                          const SizedBox(height: 15),
                          CommonTextFormFiled(
                              label: 'City',
                              errorMessage: 'Please enter city',
                              name: 'city'),
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

                          FormBuilderCheckboxGroup(
                            name: 'Hobbies',
                            options: _hobby.map((e) =>  FormBuilderFieldOption(value: e,)).toList(),
                            initialValue: _selectedHobby,
                            onChanged:(value){
                              _selectedHobby=[];
                             _selectedHobby.addAll(value!);
                             print(_selectedHobby);
                            },
                          ),
                          const SizedBox(height: 45),
                          SizedBox(
                              height: 50,
                              width: MediaQuery.sizeOf(context).width,
                              child: RoundedElevatedButton(
                                title: _title == 'Create\nAccount'
                                    ? "Sign Up"
                                    : "Update Profile",
                                voidCallback: () async {
                                  if (_formKey.currentState!
                                      .saveAndValidate()) {
                                    var prefs =
                                        await SharedPreferences.getInstance();
                                    var sharedPreferences =
                                        SharedPreferencesModel(
                                            name: _formKey
                                                .currentState!.value['name'],
                                            email: _formKey
                                                .currentState!.value['email'],
                                            password: _formKey.currentState!
                                                .value['password'],
                                            confirmPassword: _formKey
                                                .currentState!
                                                .value['confirmPassword'],
                                            phoneNumber: _formKey.currentState!
                                                .value['phoneNumber'],
                                            dob: _formKey.currentState!
                                                .value['dateOfBirth'],
                                            country: _formKey
                                                .currentState!.value['country'],
                                            state: _formKey
                                                .currentState!.value['state'],
                                            city: _formKey
                                                .currentState!.value['city'],
                                            profile: _path,
                                            hobby: _selectedHobby);
                                    await prefs.setString(
                                        SharedPreferencesKey.userModel,
                                        jsonEncode(sharedPreferences.toJson()));
                                    showSnackBar(
                                        _title == 'Create\nAccount'
                                            ? 'SignUp Successfully'
                                            : 'Profile Updated Successfully',
                                        context);
                                    _title == 'Create\nAccount'
                                        ? Timer(const Duration(seconds: 5), () {
                                            Navigator.pop(context);
                                          })
                                        : null;
                                  }
                                },
                                radius: 30,
                              )),
                          //DOB country state city, hobbies
                          const SizedBox(
                            height: 30,
                          ),
                          _title == 'Create\nAccount'
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Center(
                                    child: RichText(
                                        text: TextSpan(
                                            text: "Back to",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
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
                              : SizedBox(),
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

  Future<SharedPreferencesModel?> getDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final sharedPrefData = prefs.getString(SharedPreferencesKey.userModel);
    if (sharedPrefData != null) {
      setState(() {
        final Map<String, dynamic> data = jsonDecode(sharedPrefData);
        var sharedPreferencesModel = SharedPreferencesModel.fromJson(data);
        _formKey.currentState?.fields['name']
            ?.didChange(sharedPreferencesModel.name!);
        _formKey.currentState?.fields['email']
            ?.didChange(sharedPreferencesModel.email!);
        _formKey.currentState?.fields['password']
            ?.didChange(sharedPreferencesModel.password!);
        _formKey.currentState?.fields['confirmPassword']
            ?.didChange(sharedPreferencesModel.confirmPassword!);
        _formKey.currentState?.fields['phoneNumber']
            ?.didChange(sharedPreferencesModel.phoneNumber!);
        _formKey.currentState?.fields['dateOfBirth']
            ?.didChange(sharedPreferencesModel.dob!);
        _formKey.currentState?.fields['country']
            ?.didChange(sharedPreferencesModel.country!);
        _formKey.currentState?.fields['state']
            ?.didChange(sharedPreferencesModel.state!);
        _formKey.currentState?.fields['city']
            ?.didChange(sharedPreferencesModel.city!);
        _path = sharedPreferencesModel.profile ?? "";
        var list = sharedPreferencesModel.hobby ?? [];
        if(list.isNotEmpty){
          for (var value in list) {
            _selectedHobby.add(value.toString().trim());
          }
        }
      });
    }
  }
}
