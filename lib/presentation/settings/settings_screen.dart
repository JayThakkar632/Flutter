import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widget/round_elevated_button.dart';
import '../../shared_preferences/shared_prefs_key.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedElevatedButton(title: "Logout",voidCallback: (){showAlertDialog(context,'logout');},),
          const SizedBox(
            height: 20,
          ),
          RoundedElevatedButton(title: "Delete Account",voidCallback: (){showAlertDialog(context,'delete');},)
        ],
      ),
    );
  }
}

void showAlertDialog(BuildContext context, String dialog) {
  var label= dialog == 'logout' ? 'Are you sure you wants to logout?':'Are you sure you wants to delete account?';
  showDialog(
    context: context,
    builder: (BuildContext context) =>
        AlertDialog(
          title: Text(label),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                var pref = await SharedPreferences.getInstance();
                if(dialog  == 'logout'){
                  pref.setBool(SharedPreferencesKey.isLogin, false);
                }else{
                  pref.remove(SharedPreferencesKey.isLogin);
                  pref.remove(SharedPreferencesKey.email);
                  pref.remove(SharedPreferencesKey.password);
                }
                Navigator.pushReplacement(context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: const Text('Yes'),
            ),
          ],
        ),
  );
}
