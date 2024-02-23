import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Languages { flutter, android, iOS }

class CheckBoxAndRadioButtonScreen extends StatefulWidget {
  @override
  State<CheckBoxAndRadioButtonScreen> createState() =>
      _CheckBoxAndRadioButtonScreenState();
}

class _CheckBoxAndRadioButtonScreenState
    extends State<CheckBoxAndRadioButtonScreen> {
  var isChecked = false;
  Languages lan = Languages.flutter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CheckBox",
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(children: [
          Row(
              children: [
                SizedBox(width: 18,),
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(
                          () {
                        isChecked = value!;
                      },
                    );
                  },
                  activeColor: Colors.orangeAccent,
                  checkColor: Colors.white,
                ),
                Text(
                  "Please accept terms and contions",
                  style: TextStyle(fontFamily: 'Anta-Regular', fontSize: 18),
                )
              ]),
          ListTile(
            title: const Text('Flutter'),
            leading: Radio(
              value: Languages.flutter,
              groupValue: lan,
              onChanged: (Languages? value) {
                setState(() {
                  lan = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Android'),
            leading: Radio(
              value: Languages.android,
              groupValue: lan,
              onChanged: (Languages? value) {
                setState(() {
                  lan = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('IOS'),
            leading: Radio(
              value: Languages.iOS,
              groupValue: lan,
              onChanged: (Languages? value) {
                setState(() {
                  lan = value!;
                });
              },
            ),
          ),
        ],
    )));
  }
}
