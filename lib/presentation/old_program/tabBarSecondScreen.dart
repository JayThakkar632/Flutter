import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarSecondScreen extends StatelessWidget{
  const TabBarSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("This is Second Screen",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),));
  }

}