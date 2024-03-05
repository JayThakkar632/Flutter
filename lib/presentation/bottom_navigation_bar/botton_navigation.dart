import 'package:first_flutter_demo_app/common_widget/appbar.dart';
import 'package:first_flutter_demo_app/presentation/program_list/program_list_screen.dart';
import 'package:first_flutter_demo_app/presentation/settings/settings_screen.dart';
import 'package:first_flutter_demo_app/presentation/user_profile/user_profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarView> {
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
      return Scaffold(
        appBar: appBar(
          title: _screenName.elementAt(_selectedIndex),
          context: context,
          isShowBack: false,),
        bottomNavigationBar: BottomNavigationBar(
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
        ),
        body: _pages[_selectedIndex],
      );
  }
}