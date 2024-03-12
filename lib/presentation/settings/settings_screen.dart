import 'package:first_flutter_demo_app/presentation/settings/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widget/round_elevated_button.dart';
import '../../shared_preferences/shared_prefs_key.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  late SharedPreferences _prefs;

  SettingsScreen({super.key}) {
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedElevatedButton(
            title: "Logout",
            voidCallback: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(
                        title: "Are you sure you wants to logout?",
                        positiveButtonText: 'Yes',
                        negativeButtonText: 'No',
                        positiveButtonCallBack: () {
                          _prefs.setBool(SharedPreferencesKey.isLogin, false);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        negativeButtonCallBack: () {
                          Navigator.pop(context);
                        },
                      ));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          RoundedElevatedButton(
            title: "Delete Account",
            voidCallback: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(
                        title: "Are you sure you wants to delete?",
                        positiveButtonText: 'Yes',
                        negativeButtonText: 'No',
                        positiveButtonCallBack: () {
                          _prefs.remove(SharedPreferencesKey.isLogin);
                          _prefs.remove(SharedPreferencesKey.email);
                          _prefs.remove(SharedPreferencesKey.password);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        negativeButtonCallBack: () {
                          Navigator.pop(context);
                        },
                      ));
            },
          )
        ],
      ),
    );
  }
}
