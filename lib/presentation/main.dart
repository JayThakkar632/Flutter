import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Model/beer_details.dart';
import '../firebase_options.dart';
import 'bottom_navigation_bar/botton_navigation.dart';
import 'splash/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:firebase_core/firebase_core.dart';


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

  String get name => 'foo';


  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Initialized default app $app');
  }

  Future<void> initializeDefaultFromAndroidResource() async {
    if (defaultTargetPlatform != TargetPlatform.android || kIsWeb) {
      print('Not running on Android, skipping');
      return;
    }
    FirebaseApp app = await Firebase.initializeApp();
    print('Initialized default app $app from Android resource');
  }

  Future<void> initializeSecondary() async {
    FirebaseApp app = await Firebase.initializeApp(
      name: name,
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('Initialized $app');
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
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

