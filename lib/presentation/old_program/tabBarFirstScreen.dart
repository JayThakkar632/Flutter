import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarFirstScreen extends StatelessWidget{
  const TabBarFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("This is First Screen",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),));
  }

}