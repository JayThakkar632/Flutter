import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:first_flutter_demo_app/presentation/program_list/program_list_screen.dart';
import 'package:first_flutter_demo_app/presentation/settings/settings_screen.dart';
import 'package:first_flutter_demo_app/presentation/user_profile/user_profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<String> _screenName =['Home','Profile','Settings'];

  final List<Widget> _pages = [
    const ProgramListScreen(),
    const UserProfileScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopWidget(title: _screenName.elementAt(_selectedIndex),bottomNavigationBar:
    BottomNavigationBar(
        selectedItemColor: Colors.green,
        items:const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      )
      ,child: _pages[_selectedIndex],);
  }
}