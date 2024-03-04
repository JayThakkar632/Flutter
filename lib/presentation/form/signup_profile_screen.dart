import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';


class SignUpProfileScreen extends StatefulWidget{
  const SignUpProfileScreen({super.key});

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
  var _imageOpacity = 1.0;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var dateOfBirtController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        visible ? _imageOpacity = 0.5 : _imageOpacity = 1.0;
      });
    });
    return Stack(
      children: [
        Positioned(
          right: -100,
          top: -150,
          child: Opacity(
            opacity: _imageOpacity,
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
            opacity: _imageOpacity,
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
                        errorText:
                        isValidateName ? "Please enter name" : null,
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
                    inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
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
                      errorText:
                      isValidatePassword ? "Please enter password" : null,
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
                      errorText: isValidateConfirmPassword
                          ? "Please enter confirm password"
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
                    inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\.'))],
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
                        errorText: isValidateDateOfBirth
                            ? "Please enter Date of Birth"
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
                        errorText:
                        isValidateCountry ? "Please enter Country" : null,
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
                        errorText:
                        isValidateState ? "Please enter State" : null,
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
                        errorText:
                        isValidateCity ? "Please enter City" : null,
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
                      children: List.generate(5, (index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: checkboxValues[index],
                              activeColor: Colors.green,
                              onChanged: (value) {
                                setState(() {
                                  checkboxValues[index] = value!;
                                });
                              },
                            ),
                            SizedBox(width: 8),
                            Text(checkboxText[index]),
                          ],
                        );
                      })),
                  const SizedBox(height: 45),
                  SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width,
                      child: roundedElevatedButton("Sign Up", Colors.green,
                              () async {
                            setState(() {
                              nameController.text.isEmpty
                                  ? isValidateName = true
                                  : isValidateName = false;
                              validateEmailId();
                              passwordController.text.isEmpty
                                  ? isValidatePassword = true
                                  : isValidatePassword = false;
                              confirmPasswordController.text.isEmpty
                                  ? isValidateConfirmPassword = true
                                  : isValidateConfirmPassword = false;
                              validatePhoneNumber();
                              dateOfBirtController.text.isEmpty
                                  ? isValidateDateOfBirth = true
                                  : isValidateDateOfBirth = false;
                              countryController.text.isEmpty
                                  ? isValidateCountry = true
                                  : isValidateCountry = false;
                              stateController.text.isEmpty
                                  ? isValidateState = true
                                  : isValidateState = false;
                              cityController.text.isEmpty
                                  ? isValidateCity = true
                                  : isValidateCity = false;
                            });
                            if (nameController.text.isNotEmpty &&
                                isValidateEmail &&
                                passwordController.text.isNotEmpty &&
                                confirmPasswordController.text.isNotEmpty &&
                                isValidatePhoneNumber &&
                                dateOfBirtController.text.isNotEmpty &&
                                countryController.text.isNotEmpty &&
                                stateController.text.isNotEmpty &&
                                cityController.text.isNotEmpty) {
                              if (passwordController.text.toString() ==
                                  confirmPasswordController.text.toString()) {
                                var pref = await SharedPreferences.getInstance();
                                pref.setString(
                                    name, nameController.text.toString());
                                pref.setString(
                                    email, emailController.text.toString());
                                pref.setString(
                                    password, passwordController.text.toString());
                                pref.setString(confirmPassword,
                                    confirmPasswordController.text.toString());
                                pref.setString(phoneNumber,
                                    phoneNumberController.text.toString());
                                pref.setString(dateOfBirth,
                                    dateOfBirtController.text.toString());
                                pref.setString(
                                    country, countryController.text.toString());
                                pref.setString(
                                    state, stateController.text.toString());
                                pref.setString(
                                    city, cityController.text.toString());
                                pref.setString(profile, image!.path);
                                pref.setStringList(hobbies, checkboxValues.map((value) => value.toString()).toList());
                                showSnackBar("SignUp Successfully");
                                Timer(const Duration(seconds: 5),(){
                                  Navigator.pop(context);
                                });
                              } else {
                                showSnackBar("Password mismatch");
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
                              TextStyle(color: Colors.grey, fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Sign in',
                                    style: TextStyle(
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
}