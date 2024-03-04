import 'package:first_flutter_demo_app/constant/const_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_widget/round_elevated_button.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          roundedElevatedButton("Logout", Colors.green, () {
            showAlertDialog(context,'logout');
          }, 20),
          const SizedBox(
            height: 20,
          ),
          roundedElevatedButton("Delete Account", Colors.green, () {
            showAlertDialog(context,'delete');
          }, 20),
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
                  pref.setBool(Constants.IS_LOGIN, false);
                }else{
                  pref.remove(Constants.IS_LOGIN);
                  pref.remove(Constants.EMAIL);
                  pref.remove(Constants.PASSWORD);
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
