import 'package:first_flutter_demo_app/main.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends State<SignInScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  Future loginApi() async {
    // Make a POST request
    var response = await http.post(
      Uri.https('dummyjson.com', '/auth/login'),
      body: {'username': emailController.text.toString(), 'password': passController.text.toString()},
    );

    if (response.statusCode == 200) {
      showSnackBar('Login successful');
      var pref=await SharedPreferences.getInstance();
      pref.setBool("isLogin", true);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage()));
    } else {
      showSnackBar('Please provide valid credentials');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.arrow_back_ios_sharp),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                child: TextField(
                  controller: emailController,
                  decoration: editText('User name', 50, false),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: TextField(
                  controller: passController,
                  decoration: editText('Password', 50, false),
                  maxLines: 1,
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Container(
                    width: double.infinity,
                    height: 60,
                    child: roundedElevatedButton('LOGIN', Colors.black, () async {
                      var pref=await SharedPreferences.getInstance();
                      /*String? emailId=pref.getString("emailId");
                      String? password=pref.getString("password");*/
                      loginApi();
                      /*if(emailController.text.toString() == emailId && passController.text.toString() == password){
                        pref.setBool("isLogin", true);
                        _login();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      }else{
                        var snackBar= SnackBar(
                          content: Text("Plese provide valid credentials"),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: (){
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            },
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )

                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }*/


                    },50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showSnackBar(String msg){
    var snackBar= SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: 'OK',
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
