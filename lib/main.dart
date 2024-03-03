import 'dart:io';
import 'package:first_flutter_demo_app/beerVIewScreen.dart';
import 'package:first_flutter_demo_app/loginScreen.dart';
import 'package:first_flutter_demo_app/pojo/BeerDetails.dart';
import 'package:first_flutter_demo_app/sIgnUpScreenOne.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:first_flutter_demo_app/userListScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'splashScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';

var page = 1;
List<BeerDetails> beers = [];
bool isLoading = false;
ScrollController scrollController = ScrollController();
var textFiledSearch = TextEditingController();
var searchingText = "";
late http.Response response;
var emailController = TextEditingController();
var passwordController = TextEditingController();
var confirmPasswordController = TextEditingController();
var nameController = TextEditingController();
var phoneNumberController = TextEditingController();
var dateOfBirtController = TextEditingController();
var countryController = TextEditingController();
var stateController = TextEditingController();
var cityController = TextEditingController();
XFile? image;
var path='';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarView(),
    );
  }
}

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarView> {
  int selectedIndex = 0;

  static const List item = [
    Listing(),
    Profile(),
    Settings(),
  ];
  final List<String> appBarTitles = ['Home', 'Profile', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          appBarTitles[selectedIndex],
          style: toolBarTitle(),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        elevation: 0.0,
        onTap: onItemClicked,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
      body: item.elementAt(selectedIndex),
    );
  }

  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class Listing extends StatefulWidget {
  const Listing({super.key});

  @override
  State<Listing> createState() => _ListingState();
}

class ColorName {
  final Color color;
  final String name;

  ColorName({required this.color, required this.name});
}

class _ListingState extends State<Listing> {
  final List<ColorName> arrayList = [
    ColorName(color: Colors.red, name: 'Beer'),
    ColorName(color: Colors.green, name: 'User Listing'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigateToScreen(context, index);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: arrayList[index].color,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                height: 100,
                child: Center(
                    child: Text(
                  arrayList[index].name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
              ),
            ),
          );
        },
        itemCount: arrayList.length,
      ),
    );
  }

  void navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BeerViewScreen(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserListScreen(),
          ),
        );
        break;
    }
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isValidateEmail = true;
  bool isValidatePassword = false;
  bool isValidateName = false;
  bool isValidatePhoneNumber = false;
  bool isValidateConfirmPassword = false;
  bool isValidateDateOfBirth = false;
  bool isValidateCountry = false;
  bool isValidateState = false;
  bool isValidateCity = false;
  var opacityOfImage = 1.0;
  var selectedGender = "";
  final phoneNumberValidator = RegExp(r'^[0-9]{10}$');
  var errorMsg = null;
  var emailErrorMsg = null;
  List<String> gender = ['Male', 'Female', 'Other'];
  List<bool> checkboxValues = [false, false, false, false, false];
  List<String> checkboxText = [
    'Reading',
    'Cooking',
    'Playing',
    'Travelling',
    'Gaming'
  ];
  DateTime? selectedDate;

  @override
  void initState() {
    setValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Edit\nProfile",
                      style: TextStyle(fontSize: 35, color: Colors.green),
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
                                backgroundImage: FileImage(File(path)),
                              )
                            : const Text(''),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
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
                              // Adjust the space between checkbox and label
                              Text(checkboxText[index]),
                            ],
                          );
                        })),
                    const SizedBox(height: 45),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          child: roundedElevatedButton("Save", Colors.green,
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
                                var pref =
                                    await SharedPreferences.getInstance();
                                pref.setString(
                                    name, nameController.text.toString());
                                pref.setString(
                                    email, emailController.text.toString());
                                pref.setString(password,
                                    passwordController.text.toString());
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
                                print(emailController.text.toString());
                              } else {
                                showSnackBar("Password mismatch");
                              }
                            }
                          }, 30)),
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

  void showSnackBar(String msg) {
    var snackBar = SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      isValidatePhoneNumber=true;
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
      isValidateEmail=true;
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
      path=image!.path;
    });
  }
}

Future<void> setValue() async {
  var pref = await SharedPreferences.getInstance();
  nameController.text=pref.getString(name)!;
  emailController.text=pref.getString(email)!;
  passwordController.text=pref.getString(password)!;
  confirmPasswordController.text=pref.getString(confirmPassword)!;
  phoneNumberController.text=pref.getString(phoneNumber)!;
  dateOfBirtController.text=pref.getString(dateOfBirth)!;
  countryController.text=pref.getString(country)!;
  stateController.text=pref.getString(state)!;
  cityController.text=pref.getString(city)!;
  path=pref.getString(profile)!;
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            roundedElevatedButton("Logout", Colors.green, () {
              showLogoutDialog(context);
            }, 20),
            const SizedBox(
              height: 20,
            ),
            roundedElevatedButton("Delete Account", Colors.green, () {
              showDeleteAccount(context);
            }, 20),
          ],
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Are you sure you wants to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              var pref = await SharedPreferences.getInstance();
              pref.setBool(login, false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void showDeleteAccount(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Are you sure you wants to delete account?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              var pref = await SharedPreferences.getInstance();
              pref.remove(login);
              pref.remove(email);
              pref.remove(password);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
