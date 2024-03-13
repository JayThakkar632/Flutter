import 'dart:ui';
import 'package:flutter/material.dart';
import '../ui_helper/common_style.dart';

class RoundedElevatedButton extends StatelessWidget{
  String title='';
  Color color;
  VoidCallback voidCallback;
  double radius;
  double height;
  double? width;
  RoundedElevatedButton({super.key, required this.title,this.color=Colors.green,required this.voidCallback,this.radius=20,this.height=50,this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
           onPressed: (){
             voidCallback();
           },
      style: ElevatedButton.styleFrom(backgroundColor: color,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
        child: Text(title,style: styleForButton(Colors.white),),
      ),
    );

  }
}




