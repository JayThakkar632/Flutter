import 'package:first_flutter_demo_app/drawerScreen.dart';
import 'package:first_flutter_demo_app/tabBarMainScreen.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';
import 'checkBoxAndRadioScreen.dart';
import 'nestedTabBarMainScreen.dart';
import 'splashScreen.dart';

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
  const MyHomePage();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Home Screen",style: toolBarTitle(),),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            ElevatedButton(
              child: Text("Simple Alert Dialog"),
              onPressed: (){
                showSimpleAlertDialog(context);

              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: Text("Dialog With Input"),
              onPressed: (){
                showAlertDialogWithInput(context);
              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: Text("Confirmation Dialog"),
              onPressed: (){
                showAlertDialogWithConfirmation(context);
              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: Text("Choose Options Dialog"),
              onPressed: (){
                showAlertDialogWithMultipleOptions(context);
              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: Text("TabBar Demo"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TabBarMainScreen()));
              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: Text("Nested TabBar Demo"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NestedTabBarMainScreen()));
              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: Text("Drawer"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerScreen()));
              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: Text("CheckBox And Radio Button"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckBoxAndRadioButtonScreen()));
              },
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

void showSimpleAlertDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => AlertDialog(
    title: Text("Alert Dialog"),
    content: Text('Description'),
    actions:[
      TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: const Text('OK'),
      ),
    ],
  ));
}

void showAlertDialogWithInput(BuildContext context) {
  showDialog(context: context, builder: (context) => AlertDialog(
    title: Text("Alert Dialog"),
    content: TextField(
      decoration: editText("Name", 10, false),
    ),
    actions:[
      TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: const Text('OK'),
      ),
    ],
  ));
}

void showAlertDialogWithConfirmation(BuildContext context) {
  showDialog(context: context, builder: (context) => AlertDialog(
    title: Text("Are you sure You wants to delete this account?",style: TextStyle(fontSize: 18),),
    actions:[
      TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, 'Delete'),
        child: const Text('Delete'),
      ),
    ],
  ));
}

void showAlertDialogWithMultipleOptions(BuildContext context) {
  showDialog(context: context, builder: (context) => (
    SimpleDialog(
      title: Text("Select Options"),
      children: [
        SimpleDialogOption(
         child: Text("Apple"),
          onPressed: (){
           Navigator.pop(context);
          },
        ),
        SimpleDialogOption(
          child: Text("Banana"),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        SimpleDialogOption(
          child: Text("Graps"),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    )
  ));
}

