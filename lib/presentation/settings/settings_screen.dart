import 'package:first_flutter_demo_app/presentation/settings/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widget/round_elevated_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var pref = SharedPreferences.getInstance();
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
                          Navigator.pop(context);
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
                          Navigator.pop(context);
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


// AlertDialog(
//   title: Text(label),
//   actions: <Widget>[
//     TextButton(
//       onPressed: () => Navigator.pop(context),
//       child: const Text('No'),
//     ),
//     TextButton(
//       onPressed: () async {
//         var pref = await SharedPreferences.getInstance();
//         if(dialog  == 'logout'){
//           pref.setBool(SharedPreferencesKey.isLogin, false);
//         }else{
//           pref.remove(SharedPreferencesKey.isLogin);
//           pref.remove(SharedPreferencesKey.email);
//           pref.remove(SharedPreferencesKey.password);
//         }
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(
//                 builder: (context) => const LoginScreen()));
//       },
//       child: const Text('Yes'),
//     ),
//   ],
// ),
