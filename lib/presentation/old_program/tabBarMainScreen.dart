import 'package:first_flutter_demo_app/presentation/old_program/tabBarFirstScreen.dart';
import 'package:first_flutter_demo_app/presentation/old_program/tabBarSecondScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarMainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("TabBar Demo")),
            backgroundColor: Colors.grey,
            bottom:TabBar(
              tabs: [
                Tab(text: "Tab1",icon: Icon(Icons.contact_phone),),
                Tab(text: "Tab2",icon: Icon(Icons.camera),),
              ],
            ) ,
          ),
          body: TabBarView(
            children: [
              TabBarFirstScreen(),
              TabBarSecondScreen()
            ],
          ),
        ),
      ),
    );
  }

}