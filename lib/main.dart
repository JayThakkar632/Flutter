import 'dart:convert';
import 'package:first_flutter_demo_app/beerVIewScreen.dart';
import 'package:first_flutter_demo_app/loginScreen.dart';
import 'package:first_flutter_demo_app/pojo/BeerDetails.dart';
import 'package:first_flutter_demo_app/sIgnUpScreenOne.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:first_flutter_demo_app/userListScreen.dart';
import 'package:flutter/material.dart';
import 'beerDetailsScreen.dart';
import 'splashScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


var page = 1;
List<BeerDetails> beers = [];
bool isLoading = false;
ScrollController scrollController = ScrollController();
var textFiledSearch = TextEditingController();
var searchingText = "";


late http.Response response;

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
        backgroundColor: Colors.pinkAccent,
        title: Text(appBarTitles[selectedIndex],
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
    ColorName(color: Colors.blue, name: 'Blue'),
    ColorName(color: Colors.yellow, name: 'Yellow'),
    ColorName(color: Colors.orange, name: 'Orange'),
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
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
              var pref=await SharedPreferences.getInstance();
              pref.setBool(login, false);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
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
              var pref=await SharedPreferences.getInstance();
              pref.remove(login);
              pref.remove(email);
              pref.remove(password);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
