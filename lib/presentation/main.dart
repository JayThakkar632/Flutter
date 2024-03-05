import 'package:flutter/material.dart';
import '../Model/beer_details.dart';
import 'bottom_navigation_bar/botton_navigation.dart';
import 'splash/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

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
var checkboxValues = [false, false, false, false, false];
XFile? image;
var path = '';

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
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarView(),
    );
  }
}

